import 'dart:math';

import 'package:iot_app/http_client/http_io.dart';

class FakeHTTPClient extends HttpIO {
  final _ledsUrl = 'http://esp8266.local/api/leds';
  final _tempUrl = 'http://esp8266.local/api/temperature';

  final String _ledsBody = '''[
  {   "id":0,
      "color": "blue",
      "status": false
  },
  {   "id":1,
      "color": "yellow",  
      "status": true
  },
  {   "id":2,
      "color": "white",  
      "status": true
  },
  {   "id":1,
      "color": "red",  
      "status": true
  },
  {   "id":1,
      "color": "green",  
      "status": true
  }
] ''';

  String get _tempBody {
    return '''{
    "temperature_in_celsius": ${27.4 + 2 * Random().nextDouble()}
} ''';
  }

  @override
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    if (url == _ledsUrl) {
      return _ledsBody;
    } else if (url == _tempUrl) {
      return _tempBody;
    }

    return '';
  }

  Future<String> post(String url, String body) async {
    await Future.delayed(const Duration(seconds: 1));
    return body;
  }
}
