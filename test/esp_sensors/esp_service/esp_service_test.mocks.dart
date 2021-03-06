// Mocks generated by Mockito 5.0.17 from annotations
// in iot_app/test/esp_sensors/esp_service/esp_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:iot_app/http_client/http_io.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [HttpIO].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpIO extends _i1.Mock implements _i2.HttpIO {
  MockHttpIO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> get(String? url) =>
      (super.noSuchMethod(Invocation.method(#get, [url]),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
  @override
  _i3.Future<String> post(String? url, String? body) =>
      (super.noSuchMethod(Invocation.method(#post, [url, body]),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
}
