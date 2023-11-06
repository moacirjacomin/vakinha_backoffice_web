import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../data/models/payment_type_model.dart';
import '../../domain/usecases/add_payment_type_usecase.dart';
import '../../domain/usecases/get_payment_type_usecase.dart';
import '../../domain/usecases/update_payment_type_usecase.dart';

part 'payment_type_state.dart';

class PaymentTypeCubit extends Cubit<PaymentTypeState> {
  final GetPaymentTypeUsecase getPaymentTypeUsecase;
  final AddPaymentTypeUsecase addPaymentTypeUsecase;
  final UpdatePaymentTypeUsecase updatePaymentTypeUsecase;
  final SharedNavigator sharedNavigator;

  PaymentTypeCubit(
    this.getPaymentTypeUsecase,
    this.addPaymentTypeUsecase,
    this.updatePaymentTypeUsecase,
    this.sharedNavigator,
  ) : super(PaymentTypeState());

  void changeFilter(bool? newValue) => loadPaymentTypes(newValue);

  Future<void> addOrUpdatePaymentType(PaymentTypeModel paymentType, bool isUpdate) async {
    print('... CUBIT payment type isUpdate=$isUpdate paymentType=${paymentType}');

    // emit(state.copyWith(status: Status.loading));

    // await Future.delayed(Duration(seconds: 3));

    // emit(state.copyWith(status: Status.success));

    //addPaymentTypeUsecase updatePaymentTypeUsecase

    // if() UpdatePaymentTypeUsecase
    final result = isUpdate ? await updatePaymentTypeUsecase(paymentType) : await addPaymentTypeUsecase(paymentType);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (paymentTypeList) {
        // emit(state.copyWith(status: Status.success));
        loadPaymentTypes(state.filterEnable); 
      },
    );
  }

  Future loadPaymentTypes(bool? enable) async {
    emit(state.copyWith(status: Status.loading));
    final result = await getPaymentTypeUsecase(enable);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (paymentTypeList) {
        emit(state.copyWith(status: Status.success, paymentTypeList: paymentTypeList, filterEnable: enable));
      },
    );
  }
}
