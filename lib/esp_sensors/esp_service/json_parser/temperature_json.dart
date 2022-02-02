
import 'json_parser_exception.dart';

class TemperatureJson {
  final _jsonID = 'temperature_in_celsius';

  double parse(dynamic json) {
    final value = json[_jsonID];
    if (value.runtimeType != double) {
      throw JsonParserException(
          'Parsing TemperatureJson: Temperature is not found, found $json');
    }

    return value as double;
  }

  Map<String, double> toMap(double temperatureInCelsius) =>
      {_jsonID: temperatureInCelsius};
}
