import '../../data/models/order_produt_dto.dart';
import '../../../payment/data/models/payment_type_model.dart';
import '../../../user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../../payment/domain/repositories/payment_repository.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../data/models/order_dto.dart';
import '../../data/models/order_model.dart';
import '../repositories/order_repository.dart';

class GetOneOrderUsecase extends UseCase<OrderDto, int> {
  final OrderRepository orderRepository;
  final ProductRepository productRepository;
  final PaymentRepository paymentRepository;
  final UserRepository userRepository;

  GetOneOrderUsecase({
    required this.orderRepository,
    required this.productRepository,
    required this.paymentRepository,
    required this.userRepository,
  });

  Future<List<OrderProductDto>> _orderProductParse(OrderModel order) async {
    final orderProducts = <OrderProductDto>[];

    final productsFuture = order.orderProducts.map((e) => productRepository.getByIdProductDirect(e.productId)).toList();

    final products = await Future.wait(productsFuture);

    for (var i = 0; i < order.orderProducts.length; i++) {
      final orderProduct = order.orderProducts[i];
      final productDto = OrderProductDto(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );

      orderProducts.add(productDto);
    }

    return orderProducts;
  }

  @override
  Future<Either<Failure, OrderDto>> call(int params) async {
    var order = await orderRepository.getByIdOrderDirect(params)  ;

    var paymentTypeFuture = paymentRepository.getByIdPaymentTypeDirect(order.paymentTypeId);
    var userFuture = userRepository.getByIdUserDirect(order.userId);
    var orderProductsFuture = _orderProductParse(order);

    final response = await Future.wait([
      paymentTypeFuture,
      userFuture,
      orderProductsFuture,
    ]);

    return Right(OrderDto(
      id: order.id,
      date: order.date,
      status: order.status,
      orderProducts: response[2] as List<OrderProductDto>,
      user: response[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentType: response[0] as PaymentTypeModel,
    ));
  }
}
