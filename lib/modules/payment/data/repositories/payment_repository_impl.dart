import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';
import '../models/payment_type_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource paymentRemoteDatasource;
  final ErrorsReport errorsReport;

  PaymentRepositoryImpl({
    required this.paymentRemoteDatasource,
    required this.errorsReport,
    // required this.dio,
  });

 
  @override
  Future<Either<Failure, List<PaymentTypeModel>>> getAllPaymentType(bool? enabled) async {
    try {
      final result = await paymentRemoteDatasource.getAllPaymentType(enabled);

      return Right(result);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, PaymentTypeModel>> getByIdPaymentType(int id) async {
    try {
      final result = await paymentRemoteDatasource.getByIdPaymentType(id);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<  PaymentTypeModel> getByIdPaymentTypeDirect(int id) async {
    try {
      final result = await paymentRemoteDatasource.getByIdPaymentType(id);

      return result;
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      throw Exception(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> addPaymentType(PaymentTypeModel paymentType) async {
    try {
      final result = await paymentRemoteDatasource.addPaymentType(paymentType);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> updatePaymentType(PaymentTypeModel paymentType) async {
    try {
      final result = await paymentRemoteDatasource.updatePaymentType(paymentType);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
  
 
}
