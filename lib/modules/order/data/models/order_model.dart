import 'dart:convert';

import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_status.dart';
import 'order_product_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required int id,
    required DateTime date,
    required OrderStatus status,
    required List<OrderProductModel> orderProducts,
    required int userId,
    required String address,
    required String cpf,
    required int paymentTypeId,
  }) : super(
          id: id,
          date: date,
          status: status,
          orderProducts: orderProducts,
          userId: userId,
          address: address,
          cpf: cpf,
          paymentTypeId: paymentTypeId,
        );

  @override
  String toString() {
    return 'OrderModel(id: $id, status: $status,  date: $date)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status.acronym,
      'products': orderProducts.map((e) => e.toMap()).toList(),
      'user_id': userId,
      'address': address,
      'cpf': cpf,
      'payment_method_id': paymentTypeId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date']),
      status: OrderStatus.parse(map['status']),
      orderProducts: List<OrderProductModel>.from(
        (map['products'] as List<dynamic>).map<OrderProductModel>(
          (opm) => OrderProductModel.fromMap(opm as Map<String, dynamic>),
        ),
      ),
      userId: (map['user_id'] ?? 0) as int,
      address: map['address'] ?? '',
      cpf: map['cpf'] ?? '',
      paymentTypeId: (map['payment_method_id'] ?? 0) as int,
    );
  }

  static List<OrderModel> fromJsonList(List<dynamic> json) {
    var list = <OrderModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => OrderModel.fromMap(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
