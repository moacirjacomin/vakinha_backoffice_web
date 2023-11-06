import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {  
  final UserRemoteDatasource userRemoteDatasource;
  final ErrorsReport errorsReport;

  UserRepositoryImpl({
    required this.userRemoteDatasource,
    required this.errorsReport,
  });
 
  @override
  Future<Either<Failure, UserModel>> getByIdUser(int id) async {
    try {
      final result = await userRemoteDatasource.getByIdUser(id);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<  UserModel> getByIdUserDirect(int id) async {
    try {
      final result = await userRemoteDatasource.getByIdUser(id);

      return result;
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      throw Exception(Failure(exception: error));
    }
  }
 
}
