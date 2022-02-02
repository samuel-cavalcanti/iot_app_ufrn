import 'dart:io';

import 'package:http/http.dart' as http;

class HttpIO {
  HttpIO();

  Future<String> get(String url) async {
    final response = await http.get(Uri.parse(url));

    _checkStatusCode(response.statusCode);

    return response.body;
  }

  Future<String> post(String url, String body) async {
    final response = await http.post(Uri.parse(url), body: body);

    _checkStatusCode(response.statusCode);

    return response.body;
  }

  void _checkStatusCode(int statusCode) {
    if (statusCode != 200) {
      throw HttpIOException('Request Error $statusCode');
    }
  }
}

class HttpIOException extends IOException {
  final String message;

  HttpIOException(this.message);

  @override
  String toString() => message;
}
