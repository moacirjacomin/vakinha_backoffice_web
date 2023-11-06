import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/order_model.dart';
import '../entities/order_status.dart';
import '../repositories/order_repository.dart';

class GetOrderUsecase extends UseCase<List<OrderModel>, GetOrderParams> {
  final OrderRepository repository;

  GetOrderUsecase({required this.repository});

  @override
  Future<Either<Failure, List<OrderModel>>> call(params) async => repository.getAllOrder(params.date, params.status);
}

class GetOrderParams{
  final DateTime date;
 final OrderStatus? status;

  GetOrderParams({required this.date, this.status});
}


