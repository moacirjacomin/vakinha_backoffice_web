
import '../../../payment/data/models/payment_type_model.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/entities/order_status.dart';
import 'order_produt_dto.dart';

class OrderDto {
  final int id;
  final DateTime date; 
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final UserModel user; 
  final String address; 
  final String cpf; 
  final PaymentTypeModel paymentType;
  
  OrderDto({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProducts,
    required this.user,
    required this.address,
    required this.cpf,
    required this.paymentType,
  });
}

