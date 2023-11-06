import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/order_model.dart';
import '../entities/order_status.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getAllOrder(DateTime date, OrderStatus? status);
  Future<Either<Failure, OrderModel>> getByIdOrder(int id);
  Future<OrderModel> getByIdOrderDirect(int id);
  Future<Either<Failure, void>> addOrder(OrderModel product);
  Future<Either<Failure, void>> updateOrder(OrderModel product);
  Future<Either<Failure, void>> updateStatusOrder(int orderId, OrderStatus newStatus);
}
