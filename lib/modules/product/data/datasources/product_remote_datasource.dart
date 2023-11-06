import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../_shared/data/network/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProduct(String? name);
  Future<ProductModel> getByIdProduct(int id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);

  Future<String> uploadImageProduct(Uint8List file, String filename);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const ProductRemoteDatasourceImpl({
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<void> addProduct(ProductModel product) async {
    print('... DATA SOURCE addProduct   product=$product');
    await loggedDio.post(
      appNetwork.product, // /products
      data: product.toMap(),
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    print('... DATA SOURCE deleteProduct   id=$id');
    await loggedDio.delete(appNetwork.product + '/$id');
  }

  @override
  Future<List<ProductModel>> getAllProduct(String? name) async {
    print('... DATA SOURCE getAllProduct   name=$name');
    var result = await loggedDio.get(appNetwork.product, // /products
        queryParameters: {if (name != null) 'name': name});

    print('... DATA SOURCE getAllPaymentType  result.data=${result.data}');

    return ProductModel.fromJsonList(result.data);
  }

  @override
  Future<ProductModel> getByIdProduct(int id) async {
    print('... DATA SOURCE getByIdProduct   id=$id');
    var result = await loggedDio.get(appNetwork.product + '/$id');

    print('... DATA SOURCE result.data=${result.data}');

    return ProductModel.fromMap(result.data);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await loggedDio.put(
      appNetwork.product + '/${product.id}', // /products
      data: product.toMap(),
    );
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String filename) async {
    print('... DATA SOURCE uploadImageProduct   filename=$filename');

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(file, filename: filename)
    });

    var result = await loggedDio.post(
      appNetwork.upload , // /products
      data: formData,
    );

       print('... DATA SOURCE result.data=${result.data}');

    return result.data['url'];
    
  }
}
