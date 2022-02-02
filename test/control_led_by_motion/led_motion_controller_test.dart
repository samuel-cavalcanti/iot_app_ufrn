import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_app/control_led_by_motion/led_motion_controller.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:iot_app/esp_sensors/models/led.dart';
import 'package:iot_app/motion_sensor/motion_sensor_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'led_motion_controller_test.mocks.dart';

@GenerateMocks([LedsStore, MotionSensor])
void main() {
  final ledsStore = MockLedsStore();

  final sensors = MockMotionSensor();

  test('test success change led motion ', () async {
    final leds = [
      Led(id: 0, color: LedColor.blue, status: LedStatus.off),
      Led(id: 1, color: LedColor.yellow, status: LedStatus.on),
      Led(id: 2, color: LedColor.red, status: LedStatus.off),
      Led(id: 3, color: LedColor.white, status: LedStatus.off),
    ].map((e) => ValueNotifier(e)).toList();

    when(ledsStore.leds).thenAnswer((_) => leds);

    when(sensors.accelerometer)
        .thenAnswer((_) => Stream<List<double>>.fromIterable([
              [10.1, 10.1, 10.1],
            ]));

    final yellowLed = leds[1];

    when(ledsStore.updateLedStatus(yellowLed))
        .thenAnswer((realInvocation) async {
      await Future.delayed(const Duration(microseconds: 1));
      yellowLed.value =
          Led(id: 1, color: LedColor.yellow, status: LedStatus.off);
    });

    expect(yellowLed.value.status, LedStatus.on);

    final motionController =
        LedMotionController(ledsStore: ledsStore, sensors: sensors);

    await untilCalled(ledsStore.updateLedStatus(yellowLed));

    expect(yellowLed.value.status, LedStatus.off);
  });
}
