import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../entities/order_status.dart';
import '../repositories/order_repository.dart';

class UpdateStatusOrderUsecase extends UseCase<void, UpdateStatusOrderParams> {
  final OrderRepository repository;

  UpdateStatusOrderUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateStatusOrderParams params) async => repository.updateStatusOrder(params.orderId, params.newStatus);
}

class UpdateStatusOrderParams {
  final int orderId;
  final OrderStatus newStatus;

  UpdateStatusOrderParams({
    required this.orderId,
    required this.newStatus,
  });
}
