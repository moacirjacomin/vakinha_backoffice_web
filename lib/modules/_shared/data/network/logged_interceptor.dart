import '../storage/base_storage.dart';
import '../../domain/usecases/authentication/logout_usecase.dart';
import 'package:dio/dio.dart';

import '../../constants/core_network.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/usecases/authentication/get_current_user_usecase.dart';
import '../../domain/usecases/authentication/update_auth_user_usecase.dart';
import '../../shared_navigator.dart';

class LoggedInterceptor implements InterceptorsWrapper {
  final UpdateCurrentUserUsecase? updateCurrentUserUsecase;
  final GetCurrentUserUsecase? getCurrentUserUsecase;
  final LogoutUsecase? logoutUsecase;
  // final VoidCallback? onUnauthorized;
  final BaseStorage localStorage;
  final SharedNavigator sharedNavigator;

  LoggedInterceptor({
    this.updateCurrentUserUsecase,
    this.getCurrentUserUsecase,
    // this.onUnauthorized,
    this.logoutUsecase,
    required this.localStorage,
    required this.sharedNavigator,
  });

  CurrentUser? _currentUser;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var acToken = await localStorage.getString('access_token');

    print('... interceptor acToken=${acToken}');

    options.headers.addAll({'Authorization': 'Bearer $acToken'});

    return handler.next(options);
  }

  @override
  Future onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final cookie = response.headers['set-cookie']?.first;

    if (cookie != null && cookie != _currentUser?.token) {
      _currentUser!.token = cookie;
      updateCurrentUserUsecase!(_currentUser!);
    }

    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // if (err.type == DioException && err.response!.statusCode == CoreNetwork.codeUnauthorized) {
    //   onUnauthorized?.call();
    // }
    final isRedirectError = err.message?.toLowerCase().contains('redirect') ?? false;
    final isUnauthorizedError = err.type.runtimeType == DioExceptionType && err.response?.statusCode == CoreNetwork.codeUnauthorized;

    print('... LoggedInterceptor - isRedirectError=${isRedirectError} isUnauthorizedError=$isUnauthorizedError ');
    if (isRedirectError || isUnauthorizedError) {
      // err.type = DioExceptionType;
      sharedNavigator.openLogin();
      // unawaited(logoutUsecase(LogoutParams(shouldLogInNextUser: false)));
      // logoutUsecase(LogoutParams(shouldLogInNextUser: false));
      // onUnauthorized?.call();
      if (logoutUsecase != null) {
        logoutUsecase!();
      }
    }

    return handler.next(err);
  }
}
