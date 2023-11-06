import 'package:equatable/equatable.dart';

import '../../data/models/order_product_model.dart';
import 'order_status.dart';

class OrderEntity extends Equatable {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductModel> orderProducts;
  final int userId;
  final String address;
  final String cpf;
  final int paymentTypeId;

  OrderEntity({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProducts,
    required this.userId,
    required this.address,
    required this.cpf,
    required this.paymentTypeId,
  });

  @override
  List<Object> get props => [
        id,
        date,
        status,
        orderProducts,
        userId,
        address,
        cpf,
        paymentTypeId,
      ];
}
