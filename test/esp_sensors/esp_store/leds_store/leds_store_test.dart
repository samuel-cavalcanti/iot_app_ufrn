import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/esp_sensors/esp_service/json_parser/json_parser_exception.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/views/led_list_error_view.dart';

import 'package:iot_app/esp_sensors/esp_store/leds_store/views/led_list_initial_view.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/views/led_list_success_view.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/views/led_list_loading_view.dart';
import 'package:iot_app/esp_sensors/models/led.dart';

import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';

import 'leds_store_test.mocks.dart';

void expectViews(List<Widget> expected, List<Widget> match) {
  for (int i = 0; i < expected.length; i++) {
    expect(match[i].runtimeType, expected[i].runtimeType,
        reason:
            'Expected type: ${expected[i].runtimeType}  match: ${match[i].runtimeType}');
  }
}

Future<List<Widget>> subscribeAndFetch(LedsStore store) async {
  List<Widget> values = [store.ledListView.value];

  store.ledListView.addListener(() {
    values.add(store.ledListView.value);
  });

  await store.fetch();

  return values;
}

@GenerateMocks([EspService])
void main() {
  final service = MockEspService();

  test('test success fetch Led Store', () async {
    when(service.fetchLeds()).thenAnswer((realInvocation) async {
      return [
        Led(id: 0, color: LedColor.blue, status: LedStatus.off),
        Led(id: 1, color: LedColor.yellow, status: LedStatus.on),
        Led(id: 2, color: LedColor.red, status: LedStatus.off),
        Led(id: 3, color: LedColor.white, status: LedStatus.off),
      ];
    });

    final ledStore = LedsStore(service);

    List<Widget> expectedViews = [
      const LedListInitialView(),
      const LedListLoadingView(),
      const LedListSuccessView(leds: []),
    ];

    final values = await subscribeAndFetch(ledStore);

    expectViews(expectedViews, values);
  });

  test('Fail fetch Led Store', () async {
    when(service.fetchLeds()).thenAnswer((realInvocation) async {
      throw EspServiceException('Request Error 408');
    });

    final ledStore = LedsStore(service);

    List<Widget> expectedViews = [
      const LedListInitialView(),
      const LedListLoadingView(),
      const LedListErrorView(message: 'error'),
    ];

    final values = await subscribeAndFetch(ledStore);

    expectViews(expectedViews, values);
  });

  test('Fail to Parser the json', () async {
    when(service.fetchLeds()).thenAnswer((realInvocation) async {
      throw JsonParserException('id not found, found: null');
    });

    final ledStore = LedsStore(service);

    List<Widget> expectedViews = [
      const LedListInitialView(),
      const LedListLoadingView(),
      const LedListErrorView(message: 'error'),
    ];

    final values = await subscribeAndFetch(ledStore);

    expectViews(expectedViews, values);
  });

  test('success post Led Store', () async {
    final notifier = ValueNotifier<Led>(
        Led(id: 0, color: LedColor.blue, status: LedStatus.off));

    final expectedLed = Led(id: 0, color: LedColor.blue, status: LedStatus.on);

    when(service.updateLed(expectedLed)).thenAnswer((realInvocation) async {
      await Future.delayed(const Duration(microseconds: 1));
      return expectedLed;
    });

    final ledStore = LedsStore(service);

    final future = ledStore.updateLedStatus(notifier);

    expect(notifier.value.status, LedStatus.posting);

    await future;

    expect(notifier.value.status, LedStatus.on);
  });
}
