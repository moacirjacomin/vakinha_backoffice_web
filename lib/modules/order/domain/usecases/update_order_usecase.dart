import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/order_model.dart';
import '../repositories/order_repository.dart';

class UpdateOrderUsecase extends UseCase<void, OrderModel> {
  final OrderRepository repository;

  UpdateOrderUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(OrderModel params) async => repository.updateOrder(params);
}


