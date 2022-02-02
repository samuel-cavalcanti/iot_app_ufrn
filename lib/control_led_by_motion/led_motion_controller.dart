import 'package:flutter/foundation.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:iot_app/esp_sensors/models/led.dart';
import 'package:iot_app/motion_sensor/motion_sensor_controller.dart';
import 'dart:math' as math;

class LedMotionController {
  final LedsStore ledsStore;
  final MotionSensor sensors;

  LedMotionController({required this.ledsStore, required this.sensors}) {
    sensors.accelerometer.listen((event) => _controlLed(event));
  }

  void _controlLed(List<double> accelerometerValue) {
    final magnitude = norm(accelerometerValue);
 
    if (magnitude > 6 && ledsStore.leds != null) {  // 6m/s² foi um valor obtido experimentalmente.
      final yellowLeds = ledsStore.leds!
          .where((notifier) => notifier.value.color == LedColor.yellow);

      if (yellowLeds.isNotEmpty) _updateYellowLad(yellowLeds.first);
    }
  }

  double norm(List<double> accelerometerValue) {
    double sum = 0;

    for (final value in accelerometerValue) {
      sum += value * value;
    }

    return math.sqrt(sum);
  }

  void _updateYellowLad(ValueNotifier<Led> notifier) {
    final yellowLed = notifier.value;

    if (yellowLed.status == LedStatus.posting) return;

    ledsStore.updateLedStatus(notifier);
  }
}
