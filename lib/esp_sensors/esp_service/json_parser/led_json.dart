import 'package:iot_app/esp_sensors/models/led.dart';
import 'json_parser_exception.dart';

class LedJson {
  final _ledColorMap = {
    'white': LedColor.white,
    'red': LedColor.red,
    'blue': LedColor.blue,
    'yellow': LedColor.yellow,
    'green': LedColor.green
  };
  final _ledStatusMap = {true: LedStatus.on, false: LedStatus.off};

  final String _initialErrorMessage = 'Parsing Led:';

  Map<String, dynamic> toMap(Led led) => {
        'id': led.id,
        'color': led.color.name,
        'status': led.status == LedStatus.on
      };

  Led parse(dynamic jsonLed) => Led(
      id: _getId(jsonLed['id']),
      color: _getColor(jsonLed['color']),
      status: _getStatus(jsonLed['status']));

  int _getId(dynamic id) {
    if (id == null || id.runtimeType != int) {
      _throwJsonException('id not found, found $id');
    }

    return id as int;
  }

  LedStatus _getStatus(dynamic status) {
    final ledStatus = _ledStatusMap[status];

    if (ledStatus == null) {
      _throwJsonException('Color not found for $status');
    }

    return ledStatus!;
  }

  LedColor _getColor(dynamic jsonLed) {
    if (jsonLed.runtimeType != String) {
      _throwJsonException('expected color is string, color:  $jsonLed');
    }

    final color = _ledColorMap[jsonLed];

    if (color == null) {
      _throwJsonException('Color not found for $jsonLed');
    }
    return color!;
  }

  void _throwJsonException(String message) {
    throw JsonParserException('$_initialErrorMessage $message');
  }
}
