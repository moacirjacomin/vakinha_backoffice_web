import 'package:dio/dio.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'dart:developer' as dev;

abstract class ErrorsReport {
  void log(dynamic e, StackTrace? stackTrace);
}

class ErrorsReportImpl implements ErrorsReport {
  // final crashlytics = FirebaseCrashlytics.instance;

  @override
  void log(
    dynamic error,
    StackTrace? stackTrace, {
    bool shouldLogHttpErrors = false,
  }) async {
    if (error is DioException  && !shouldLogHttpErrors) {
      return;
    }

    dev.log('ERROR',stackTrace: stackTrace, error: error);
    // await crashlytics.recordError(error, stackTrace, reason: 'Repository method failed');
  }
}
