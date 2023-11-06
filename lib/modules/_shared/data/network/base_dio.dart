import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../environment/env.dart';

abstract class BaseDio extends DioForBrowser {
  BaseDio({
    List<Interceptor>? customInterceptors,
    BaseOptions? options,
    bool isMock = false,
  }) : super(
          BaseOptions(
            baseUrl: options?.baseUrl ?? Env.instance.get('base_url'),
            connectTimeout: options?.connectTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
            receiveTimeout: options?.receiveTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
          ),
        ) {
    if (Env.instance.get('environment') == 'DEV' ) {  
      //

      interceptors.addAll([
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          maxWidth: 120,
          logPrint: (obj) => debugPrint(obj as String?),
        ),

        // LogInterceptor(
        //   requestBody: true,
        //   responseBody: true,
        //   requestHeader: true,
        // ),
      ]);
    }

    if (customInterceptors?.isNotEmpty == true) {
      interceptors.addAll(customInterceptors!);
    }

    print('--- interceptors length=${interceptors.length}');

    // print('... RODEI AQUI ${options?.baseUrl} ${CoreNetwork.baseUrl} final=${options?.baseUrl ?? CoreNetwork.baseUrl}');
    this.options = BaseOptions(
      baseUrl: options?.baseUrl ?? Env.instance.get('base_url'),
      connectTimeout: options?.connectTimeout ?? Duration(seconds: int.parse(Env.instance.get('timeout_limit'))),
    );
  }
}
