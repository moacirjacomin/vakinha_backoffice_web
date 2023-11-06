import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getAllProduct(String? name);
  Future<Either<Failure, ProductModel>> getByIdProduct(int id);
  Future<Either<Failure, void>> addProduct(ProductModel product);
  Future<Either<Failure, void>> updateProduct(ProductModel product);
  Future<Either<Failure, void>> deleteProduct(int id);
  
  Future<Either<Failure, String>> uploadImageProduct(Uint8List file, String filename);

  Future<ProductModel> getByIdProductDirect(int id);
}
