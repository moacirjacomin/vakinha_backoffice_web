import '../../../_shared/data/network/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../../domain/entities/order_status.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<List<OrderModel>> getAllOrder(DateTime date, OrderStatus? status);
  Future<OrderModel> getByIdOrder(int id);
  Future<void> addOrder(OrderModel product);
  Future<void> updateOrder(OrderModel product);
  Future<void> updateStatusOrder(int productId, OrderStatus newStatus);
}

class OrderRemoteDatasourceImpl implements OrderRemoteDatasource {
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const OrderRemoteDatasourceImpl({
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<void> addOrder(OrderModel product) async {
    print('... DATA SOURCE addOrder   product=$product');
    await loggedDio.post(
      appNetwork.order, // /orders
      data: product.toMap(),
    );
  }

  @override
  Future<List<OrderModel>> getAllOrder(DateTime date, OrderStatus? status) async {
    print('... DATA SOURCE getAllOrder   status=$status');
    var result = await loggedDio.get(appNetwork.order, // /orders
        queryParameters: {
          // 'date': date.toIso8601String(),
          if (status != null) 'status': status.acronym
        });

    print('... DATA SOURCE getAllPaymentType  result.data=${result.data}');

    return OrderModel.fromJsonList(result.data);
  }

  @override
  Future<OrderModel> getByIdOrder(int id) async {
    print('... DATA SOURCE getByIdOrder   id=$id');
    var result = await loggedDio.get(appNetwork.order + '/$id');

    print('... DATA SOURCE result.data=${result.data}');

    return OrderModel.fromMap(result.data);
  }

  

  @override
  Future<void> updateOrder(OrderModel product) async {
    await loggedDio.put(
      appNetwork.order + '/${product.id}', // /orders
      data: product.toMap(),
    );
  }

  @override
  Future<void> updateStatusOrder(int productId, OrderStatus newStatus) async {
    await loggedDio.put(
      appNetwork.order + '/${productId}', // /orders
      data: {'status': newStatus.acronym},
    );
  }
}
