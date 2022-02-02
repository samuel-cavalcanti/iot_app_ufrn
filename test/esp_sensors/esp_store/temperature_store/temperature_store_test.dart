import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/temperature_store.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/views/temperature_error_view.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/views/temperature_initial_view.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/views/temperature_loading_view.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/views/temperature_success_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../leds_store/leds_store_test.dart';
import '../leds_store/leds_store_test.mocks.dart';

void main() {
  final service = MockEspService();

  test('test success temperature store fetch', () async {
    when(service.fetchTemperature()).thenAnswer((_) async {
      return 27.0;
    });

    final tempStore = TemperatureStore(service);

    List<Widget> views = [const TemperatureInitialView()];

    tempStore.addListener(() {
      views.add(tempStore.value);
    });

    await tempStore.fetch();

    expectViews([
      const TemperatureInitialView(),
      const TemperatureLoadingView(),
      const TemperatureSuccessView(temperature: 27.0)
    ], views);
  });

  test('test fail temperature store fetch', () async {
    when(service.fetchTemperature()).thenAnswer((_) async {
      throw EspServiceException('Request Timeout 404');
    });

    final tempStore = TemperatureStore(service);

    List<Widget> views = [const TemperatureInitialView()];

    tempStore.addListener(() {
      views.add(tempStore.value);
    });

    await tempStore.fetch();

    expectViews([
      const TemperatureInitialView(),
      const TemperatureLoadingView(),
      const TemperatureErrorView(message: 'fail')
    ], views);
  });
}
