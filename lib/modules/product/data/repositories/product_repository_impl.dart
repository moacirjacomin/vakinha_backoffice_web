import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../_shared/data/error_report/errors_report.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;
  final ErrorsReport errorsReport;

  ProductRepositoryImpl({
    required this.productRemoteDatasource,
    required this.errorsReport,
    // required this.dio,
  });

  @override
  Future<Either<Failure, void>> addProduct(ProductModel product) async {
    try {
      final result = await productRemoteDatasource.addProduct(product);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      final result = await productRemoteDatasource.deleteProduct(id);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProduct(String? name) async {
    try {
      final result = await productRemoteDatasource.getAllProduct(name);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getByIdProduct(int id) async {
    try {
      final result = await productRemoteDatasource.getByIdProduct(id);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<ProductModel> getByIdProductDirect(int id) async {
    try {
      final result = await productRemoteDatasource.getByIdProduct(id);

      return result;
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      throw Exception(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel product) async {
    try {
      final result = await productRemoteDatasource.updateProduct(product);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImageProduct(Uint8List file, String filename) async {
    try {
      final result = await productRemoteDatasource.uploadImageProduct(file, filename);

      return Right(result);
    } catch (error, stackTrace) {
      errorsReport.log(error, stackTrace);
      return Left(Failure(exception: error));
    }
  }
}
