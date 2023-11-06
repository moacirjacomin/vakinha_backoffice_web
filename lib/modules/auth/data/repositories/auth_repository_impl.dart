import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
 
import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;
  final ErrorsReport errorsReport;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
    required this.errorsReport,
    // required this.dio,
  });

  @override
  Future<Either<Failure, CurrentUser>> signIn(String email, String password) async {
    try {
      final result = await authRemoteDatasource.signIn(email, password);

      authLocalDatasource.updateCurrentUser(result);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, CurrentUser>> signUp(String name, String email, String password, String type) async {
    try {
      final result = await authRemoteDatasource.signUp(name, email, password, type);

      authLocalDatasource.updateCurrentUser(result);
      
      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
