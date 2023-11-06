import 'package:dio/dio.dart';

import '../environment/env.dart';
import 'base_dio.dart';
import 'not_logged_interceptor.dart';

class NotLoggedDio extends BaseDio {
  NotLoggedDio({
    // required Environment environment,
    required NotLoggedInterceptor notLoggedInterceptor,
    BaseOptions? options,
  }) : super(
          options: options ??
              BaseOptions(
                baseUrl: options?.baseUrl ?? Env.instance.get('base_url'),
                connectTimeout: options?.connectTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
                receiveTimeout: options?.receiveTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
              ),
          isMock: Env.instance.get('environment') == 'DEV',
          customInterceptors: [
            if (Env.instance.get('environment') != 'DEV') notLoggedInterceptor,
            // if (environment is DevEnvironment) mockInterceptor,
          ],
        );
}
