import 'dart:convert';

import '../../domain/entities/order_product_entity.dart';

class OrderProductModel extends OrderProductEntity {
  OrderProductModel({
    required super.productId,
    required super.amount,
    required super.totalPrice,
  });

 
  @override
  String toString() => 'OrderProductModel(productId: $productId, amount: $amount, totalPrice: $totalPrice)';

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'amount': amount,
      'totalPrice': totalPrice,
    };
  }

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      productId: map['id']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      totalPrice: map['total_price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductModel.fromJson(String source) => OrderProductModel.fromMap(json.decode(source));
}
