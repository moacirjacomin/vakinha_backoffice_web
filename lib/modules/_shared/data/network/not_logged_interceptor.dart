import 'package:dio/dio.dart';

import '../../domain/entities/current_user.dart';
import '../../domain/usecases/authentication/get_current_user_usecase.dart';
import '../../domain/usecases/authentication/update_auth_user_usecase.dart';
import '../../utils/string_utils.dart';

class NotLoggedInterceptor implements InterceptorsWrapper {
  final UpdateCurrentUserUsecase? updateCurrentUserUsecase;
  final GetCurrentUserUsecase? getCurrentUserUsecase;

  NotLoggedInterceptor({
    this.updateCurrentUserUsecase,
    this.getCurrentUserUsecase,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }

  @override
  Future onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final cookie = response.headers['set-cookie']?.first;

    if (StringUtils.isNullOrBlank(cookie)) {
      return handler.next(response);
    }

    if (_containsUser(response.data)) {
      final newUser = CurrentUser.fromJson(response.data);
      newUser.token = cookie;

      updateCurrentUserUsecase!(newUser);
    }

    return handler.next(response);
  }

  bool _containsUser(Map<String, dynamic> data) {
    return data.containsKey('id') &&
        data.containsKey('name') &&
        data.containsKey('email')  ;
  }
}
