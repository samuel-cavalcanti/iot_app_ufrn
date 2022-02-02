import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/http_client/http_io.dart';
import '../models/led.dart';
import 'esp_sensor_json_parser.dart';

class HttpEspService implements EspService {
  final EspSensorJsonParser _jsonParser = EspSensorJsonParser();
  final HttpIO io;
  String baseURL;
  HttpEspService({required this.io, this.baseURL = 'esp8266.local'});

  @override
  Future<List<Led>> fetchLeds() async {
    final output = await io.get(_ledsUrl);

    final leds = _jsonParser.parserLeds(output);

    return leds;
  }

  @override
  Future<double> fetchTemperature() async {
    final output = await io.get(_temperatureUrl);

    return _jsonParser.parserTemperature(output);
  }

  @override
  Future<Led> updateLed(Led led) async {
    final stringJson = _jsonParser.ledToJson(led);

    final output = await io.post(_ledsUrl, stringJson);

    final responseLed = _jsonParser.parserLed(output);

    return responseLed;
  }

  String get _ledsUrl => 'http://$baseURL/api/leds';

  String get _temperatureUrl => 'http://$baseURL/api/temperature';
}
