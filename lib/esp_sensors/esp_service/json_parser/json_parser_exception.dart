
class JsonParserException implements Exception {
  final String message;
  JsonParserException(this.message);

  @override
  String toString() => message;
}
