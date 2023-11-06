import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource orderRemoteDatasource;
  final ErrorsReport errorsReport;

  OrderRepositoryImpl({
    required this.orderRemoteDatasource,
    required this.errorsReport,
  });

  @override
  Future<Either<Failure, void>> addOrder(OrderModel product) async {
    try {
      final result = await orderRemoteDatasource.addOrder(product);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrder(DateTime date, OrderStatus? status) async {
    try {
      final result = await orderRemoteDatasource.getAllOrder(date, status);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getByIdOrder(int id) async {
    try {
      final result = await orderRemoteDatasource.getByIdOrder(id);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<  OrderModel> getByIdOrderDirect(int id) async {
    try {
      final result = await orderRemoteDatasource.getByIdOrder(id);

      return result;
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      throw Exception(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrder(OrderModel product) async {
    try {
      final result = await orderRemoteDatasource.updateOrder(product);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> updateStatusOrder(int orderId, OrderStatus newStatus) async {
    try {
      final result = await orderRemoteDatasource.updateStatusOrder(orderId, newStatus);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
