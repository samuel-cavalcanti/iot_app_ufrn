import 'package:flutter/widgets.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/esp_sensors/esp_service/json_parser/json_parser_exception.dart';


import 'views/led_list_initial_view.dart';
import 'views/led_list_success_view.dart';
import 'views/led_list_loading_view.dart';
import 'views/led_list_error_view.dart';

import 'package:iot_app/esp_sensors/models/led.dart';

class LedsStore  {
  final EspService espService;
  ValueNotifier<Widget> ledListView =
      ValueNotifier<Widget>(const LedListInitialView());

  List<ValueNotifier<Led>>? leds;

  LedsStore(this.espService) : super();

  Future<void> fetch() async {
    ledListView.value = const LedListLoadingView();

    try {
      leds =
          (await espService.fetchLeds()).map((e) => ValueNotifier(e)).toList();

      ledListView.value = LedListSuccessView(leds: leds!);
    } on EspServiceException catch (e) {
      ledListView.value = LedListErrorView(message: e.message);
    } on JsonParserException catch (e) {
      ledListView.value = LedListErrorView(message: e.message);
    } on FormatException catch (_) {
      ledListView.value =
          const LedListErrorView(message: 'Fail to Decode Json');
    }
  }

  Future<void> updateLedStatus(ValueNotifier<Led> notifier) async {
    final newStatus =
        notifier.value.status == LedStatus.on ? LedStatus.off : LedStatus.on;

    final newLed = Led(
        id: notifier.value.id, color: notifier.value.color, status: newStatus);

    final loadingLed = Led(
        id: notifier.value.id,
        color: notifier.value.color,
        status: LedStatus.posting);

    notifier.value = loadingLed;

    notifier.value = await espService.updateLed(newLed);
  }
}
