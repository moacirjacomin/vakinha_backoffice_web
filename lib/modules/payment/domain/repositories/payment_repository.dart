import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/payment_type_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentTypeModel>>> getAllPaymentType(bool? enabled);
  Future<Either<Failure, PaymentTypeModel>> getByIdPaymentType(int id);
  Future<Either<Failure, void>> addPaymentType(PaymentTypeModel paymentType);
  Future<Either<Failure, void>> updatePaymentType(PaymentTypeModel paymentType);
  Future<PaymentTypeModel> getByIdPaymentTypeDirect(int id);
}
