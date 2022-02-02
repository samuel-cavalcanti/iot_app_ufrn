import 'package:iot_app/esp_sensors/models/led.dart';

abstract class EspService {
  Future<List<Led>> fetchLeds();
  Future<double> fetchTemperature();
  Future<Led> updateLed(Led led);
}

class EspServiceException implements Exception {
  final String message;
  EspServiceException(this.message);

  @override
  String toString() => message;
}
