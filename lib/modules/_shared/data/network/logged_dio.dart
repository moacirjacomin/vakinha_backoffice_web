import 'package:dio/dio.dart';

import '../environment/env.dart';
import 'base_dio.dart';
import 'logged_interceptor.dart';

class LoggedDio extends BaseDio {
  LoggedDio({
    // required Environment environment,
    required LoggedInterceptor loggedInterceptor,
    BaseOptions? options,
  }) : super(
          options: options ??
              BaseOptions(
                baseUrl: options?.baseUrl ?? Env.instance.get('base_url'),
                connectTimeout: options?.connectTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
                receiveTimeout: options?.receiveTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
              ),
          isMock: Env.instance.get('environment') == 'TEST',
          customInterceptors: [
            if (Env.instance.get('environment') != 'TEST') loggedInterceptor,
            // if (Env.instance.get('environment') == 'TEST') mockInterceptor,
          ],
        );
}
