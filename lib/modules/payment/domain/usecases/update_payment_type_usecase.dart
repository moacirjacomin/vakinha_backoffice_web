import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/payment_type_model.dart';
import '../repositories/payment_repository.dart';

class UpdatePaymentTypeUsecase extends UseCase<void, PaymentTypeModel> {
  final PaymentRepository repository;

  UpdatePaymentTypeUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(PaymentTypeModel params) async => repository.updatePaymentType(params);
}

 