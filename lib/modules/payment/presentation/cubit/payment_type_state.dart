part of 'payment_type_cubit.dart';

class PaymentTypeState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;
  final List<PaymentTypeModel>? paymentTypeList;
  final PaymentTypeModel? selectedPaymentType;
  final bool? filterEnable;

  PaymentTypeState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
    this.paymentTypeList,
    this.selectedPaymentType,
    this.filterEnable,
  });

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
        paymentTypeList,
        selectedPaymentType,
        filterEnable,
      ];

  PaymentTypeState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
    List<PaymentTypeModel>? paymentTypeList,
    PaymentTypeModel? selectedPaymentType,
    bool? filterEnable,
  }) {
    return PaymentTypeState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      paymentTypeList: paymentTypeList ?? this.paymentTypeList,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      filterEnable: filterEnable ?? this.filterEnable,
    );
  }
}
