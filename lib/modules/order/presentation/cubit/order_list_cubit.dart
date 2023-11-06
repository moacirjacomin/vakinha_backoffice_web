import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../data/models/order_dto.dart';
import '../../data/models/order_model.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/usecases/get_one_order_type_usecase.dart';
import '../../domain/usecases/get_order_usecase.dart';
import '../../domain/usecases/update_order_usecase.dart';
import '../../domain/usecases/update_status_order_usecase.dart';

part 'order_list_state.dart';



class OrderListCubit extends Cubit<OrderState> {
  final GetOrderUsecase getOrderUsecase;
  final GetOneOrderUsecase getOneOrderUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final UpdateStatusOrderUsecase updateStatusOrderUsecase;
  final SharedNavigator sharedNavigator;

  OrderListCubit(
    this.getOrderUsecase,
    this.getOneOrderUsecase,
    this.updateOrderUsecase,
    this.updateStatusOrderUsecase,
    this.sharedNavigator,
  ) : super(OrderState());

  onInit() {
    loadOrders(null);
  }

  Future<void> onChangeFilter(OrderStatus? newValue) async {
    print('... filter value=$newValue');
    loadOrders(newValue);
  }

  
  Future<void> updateOrder(OrderModel order) async {
    print('... CUBIT     order=${order}');

    emit(state.copyWith(status: StatusOrderList.loading));

    // if() UpdateOrderUsecase
    final result = await updateOrderUsecase(order);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: StatusOrderList.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (productList) {
        loadOrders(state.filterStatus);
      },
    );
  }
  
  Future<void> updateOrderStatus(OrderStatus newStatus) async {
    print('... CUBIT     nesStatus=${newStatus}');

    // emit(state.copyWith(status: StatusOrderList.loading));

    final result = await updateStatusOrderUsecase(UpdateStatusOrderParams(orderId: state.orderSelected!.id, newStatus: newStatus));

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: StatusOrderList.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (productList) {
        loadOrders(state.filterStatus);
      },
    );
  }

  Future<void> getOrderDetail(int orderId) async {
    emit(state.copyWith(status: StatusOrderList.loading));

    final result = await getOneOrderUsecase(orderId);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: StatusOrderList.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (orderDetail) {
        emit(state.copyWith(status: StatusOrderList.loaded, orderSelected: orderDetail));
      },
    );
  }

  Future loadOrders(OrderStatus? statusFilter) async {
    emit(state.copyWith(status: StatusOrderList.loading));

    var today = DateTime.now();
    var todayOnlyDate = DateTime(today.year, today.month, today.day);

    final result = await getOrderUsecase(GetOrderParams(date: todayOnlyDate, status: statusFilter));

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: StatusOrderList.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (orderList) {
        emit(state.copyWith(status: StatusOrderList.initial, orderList: orderList, filterStatus: statusFilter));
      },
    );
  }
}
