import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/payment_type_model.dart';
import '../repositories/payment_repository.dart';

class GetPaymentTypeUsecase extends UseCase<List<PaymentTypeModel>, bool?> {
  final PaymentRepository repository;

  GetPaymentTypeUsecase({required this.repository});

  @override
  Future<Either<Failure, List<PaymentTypeModel>>> call(params) async => repository.getAllPaymentType(params);
}

 