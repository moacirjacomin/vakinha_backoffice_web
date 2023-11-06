import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../constants/core_strings.dart';


class CustomError implements Exception {
  final String message;

  CustomError(this.message);
}

class Failure extends Equatable {
  final dynamic exception;
  final dynamic data;

  Failure({
    required this.exception,
    this.data,
  });

  @override
  List<Object> get props => [exception];

  String getMessage() {
    final error = exception;

    try {
      print('... error= ${error.runtimeType}');
      // print('... error.type= ${error.type.runtimeType}');
      if (error is DioException) {
        switch (error.type.runtimeType) {
          case DioExceptionType:
            if ((error.response!.data['message'] as String?)?.isNotEmpty == true) {
              return error.response!.data['message'];
            } else if ((error.response!.data['msg'] as String?)?.isNotEmpty == true) {
              return error.response!.data['msg'];
            } else if ((error.response!.data['err'] as String?)?.isNotEmpty == true) {
              return error.response!.data['err'];
            } else if ((error.response!.data['error'] as String?)?.isNotEmpty == true) {
              return error.response!.data['error'];}
            else {
              // print('... PUTX ');
              return CoreStrings.errors.unknown;
            }
          // case DioExceptionType..other:
          //   return CoreStrings.errors.withoutConnection;
          default:
            return CoreStrings.errors.unknown;
        }
      } else if (error is CustomError) {
        return error.message;
      } else {
        //  print('... PUT FF ${error.toString()} ');
         return error.toString();
        //  log('ERROR', error: error, stackTrace: );
        return CoreStrings.errors.unknown;
      }
    } catch (error) {
      // print('... PUT BLA ${error.toString()} ');
      // print(error.toString());
      // return error.toString();
      return CoreStrings.errors.unknown;
    }
  }
}
