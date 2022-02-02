import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';

import 'views/temperature_loading_view.dart';
import 'views/temperature_error_view.dart';
import 'views/temperature_success_view.dart';
import 'views/temperature_initial_view.dart';

class TemperatureStore extends ValueNotifier<Widget> {
  final EspService espService;
  TemperatureStore(this.espService) : super(const TemperatureInitialView());

  Future<void> fetch() async {
    value = const TemperatureLoadingView();

    try {
      value = TemperatureSuccessView(
        temperature: await espService.fetchTemperature(),
      );
      Future.delayed(const Duration(seconds: 1), _loop);
    } on EspServiceException catch (e) {
      value = TemperatureErrorView(message: e.message);
    }
  }

  Future<void> _loop() async {
    try {
      final temperature = await espService.fetchTemperature();
      value = TemperatureSuccessView(temperature: temperature);
      Future.delayed(const Duration(seconds: 1), _loop);
    } on EspServiceException catch (e) {
      value = TemperatureErrorView(message: e.message);
    }
  }
}
