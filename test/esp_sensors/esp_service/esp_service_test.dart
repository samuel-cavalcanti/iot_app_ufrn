// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_app/esp_sensors/esp_service/http_esp_service.dart';

import 'package:iot_app/esp_sensors/models/led.dart';
import 'package:iot_app/http_client/http_io.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'esp_service_test.mocks.dart';

@GenerateMocks([HttpIO])
void main() {
  final io = MockHttpIO();
  final espService = HttpEspService(io: io);
  final ledsUrl = 'http://esp8266.local/api/leds';
  final temperatureUrl = 'http://esp8266.local/api/temperature';

  test('test success Esp Service', () async {
    when(io.get(ledsUrl)).thenAnswer((_) async {
      final content =
          await File('test_resources/response_get_leds.json').readAsString();
      return content;
    });

    final leds = await espService.fetchLeds();

    final expectedLeds = [
      Led(id: 0, color: LedColor.blue, status: LedStatus.off),
      Led(id: 1, color: LedColor.yellow, status: LedStatus.on),
      Led(id: 2, color: LedColor.red, status: LedStatus.off),
      Led(id: 3, color: LedColor.white, status: LedStatus.off),
    ];

    for (int i = 0; i < expectedLeds.length; i++) {
      expect(leds[i], expectedLeds[i],
          reason: 'O led deve ser ${expectedLeds[i]},  encontrado ${leds[i]} ');
    }
  });

  test('test success get temperature', () async {
    when(io.get(temperatureUrl)).thenAnswer((_) async {
      final content =
          await File('test_resources/response_get_lm35.json').readAsString();
      return content;
    });

    const expectedTemperature = 27.4;

    final temperature = await espService.fetchTemperature();

    expect(temperature, expectedTemperature,
        reason:
            'A temperatura deve ser $expectedTemperature  recebida $temperature');
  });

  test('test success post Led ', () async {
    final led = Led(id: 0, color: LedColor.blue, status: LedStatus.on);
    const String body = '{"id":0,"color":"blue","status":true}';

    when(io.post(ledsUrl, body)).thenAnswer((response) async {
      return body;
    });

    final responseLed = await espService.updateLed(led);

    expect(responseLed, led);
  });
}
