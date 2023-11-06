import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetProductUsecase extends UseCase<List<ProductModel>, String?> {
  final ProductRepository repository;

  GetProductUsecase({required this.repository});

  @override
  Future<Either<Failure, List<ProductModel>>> call(params) async => repository.getAllProduct(params);
}

 