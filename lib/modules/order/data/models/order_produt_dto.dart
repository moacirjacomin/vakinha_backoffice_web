import '../../../product/data/models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;
  final double totalPrice;

  OrderProductDto({
    required this.product,
    required this.amount,
    required this.totalPrice,
  });
}
