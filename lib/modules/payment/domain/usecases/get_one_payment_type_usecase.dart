import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/payment_type_model.dart';
import '../repositories/payment_repository.dart';

class GetOnePaymentTypeUsecase extends UseCase<PaymentTypeModel, int> {
  final PaymentRepository repository;

  GetOnePaymentTypeUsecase({required this.repository});

  @override
  Future<Either<Failure, PaymentTypeModel>> call(int params) async => repository.getByIdPaymentType(params);
}

 