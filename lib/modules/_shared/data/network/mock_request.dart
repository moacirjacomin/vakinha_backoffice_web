import 'package:dio/dio.dart';

enum RequestType { post, get, put, delete }

abstract class MockRequest {
  final RequestType requestType;
  final List<String> requiredParams;
  final dynamic requestJson;
  final dynamic responseJson;
  final Headers? requestHeaders;
  final Headers? responseHeaders;

  MockRequest({
    required this.requiredParams,
    required this.requestType,
    required this.requestJson,
    required this.responseJson,
    this.requestHeaders,
    this.responseHeaders,
  });
}
