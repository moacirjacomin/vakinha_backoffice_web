part of 'order_list_cubit.dart';

enum StatusOrderList { initial, loading, loaded, success, failure }

class OrderState extends Equatable {
  final StatusOrderList status;
  final Failure? failure;
  final String? errorMessage;
  final List<OrderModel> orderList;
  final OrderStatus? filterStatus;
  final OrderDto? orderSelected;

  OrderState({
    this.status = StatusOrderList.initial,
    this.failure,
    this.errorMessage = '',
    this.orderList = const [],
    this.filterStatus,
    this.orderSelected,
  });

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
        orderList,
        filterStatus,
        orderSelected,
      ];

  OrderState copyWith({
    StatusOrderList? status,
    Failure? failure,
    String? errorMessage,
    List<OrderModel>? orderList,
    OrderStatus? filterStatus,
    OrderDto? orderSelected,
  }) {
    return OrderState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      orderList: orderList ?? this.orderList,
      filterStatus: filterStatus ?? this.filterStatus,
      orderSelected: orderSelected ?? this.orderSelected,
    );
  }
}
