import 'dart:convert';

import 'package:iot_app/esp_sensors/esp_service/json_parser/led_json.dart';
import 'package:iot_app/esp_sensors/esp_service/json_parser/temperature_json.dart';

import '../models/led.dart';

class EspSensorJsonParser {
  final LedJson _ledParser = LedJson();
  final TemperatureJson _temperatureJsonParser = TemperatureJson();

  List<Led> parserLeds(String jsonString) {
    List<dynamic> json = jsonDecode(jsonString);
    return json.map(_ledParser.parse).toList();
  }

  Led parserLed(String jsonString) {
    final json = jsonDecode(jsonString);
    return _ledParser.parse(json);
  }

  double parserTemperature(String jsonString) {
    dynamic json = jsonDecode(jsonString);
    return _temperatureJsonParser.parse(json);
  }

  String ledToJson(Led led) {
    final map = _ledParser.toMap(led);

    return jsonEncode(map);
  }
}
