import '../../../_shared/data/network/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../models/payment_type_model.dart';

abstract class PaymentRemoteDatasource {
  Future<List<PaymentTypeModel>> getAllPaymentType(bool? enable);
  Future<PaymentTypeModel> getByIdPaymentType(int id);
  Future<void> addPaymentType(PaymentTypeModel paymentType);
  Future<void> updatePaymentType(PaymentTypeModel paymentType);
}

class PaymentRemoteDatasourceImpl implements PaymentRemoteDatasource {
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const PaymentRemoteDatasourceImpl({
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<PaymentTypeModel> getByIdPaymentType(int id) async {
    // REAL request
    var result = await loggedDio.get(appNetwork.paymentType + '/$id');

    print('... DATA SOURCE result.data=${result.data}');

    return PaymentTypeModel.fromMap(result.data);
  }

  @override
  Future<List<PaymentTypeModel>> getAllPaymentType(bool? enable) async {
    var result = await loggedDio.get(appNetwork.paymentType, // /auth
        queryParameters: {if (enable != null) 'enabled': enable});

    print('... DATA SOURCE getAllPaymentType  result.data=${result.data}');

    return PaymentTypeModel.fromJsonList(result.data);
  }

  @override
  Future<void> addPaymentType(PaymentTypeModel paymentType) async {
    await loggedDio.post(
      appNetwork.paymentType, // /auth
      data: {
        'name': paymentType.name,
        'acronym': paymentType.acronym,
        'enabled': paymentType.enable,
      },
    );
  }

  @override
  Future<void> updatePaymentType(PaymentTypeModel paymentType) async {
    await loggedDio.put(
      appNetwork.paymentType+'/${paymentType.id}', // /auth
      data: {
        'name': paymentType.name,
        'acronym': paymentType.acronym,
        'enabled': paymentType.enable,
      },
    );
  }
}
