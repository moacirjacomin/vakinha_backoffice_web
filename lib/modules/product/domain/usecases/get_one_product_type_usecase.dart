import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetOneProductUsecase extends UseCase<ProductModel, int> {
  final ProductRepository repository;

  GetOneProductUsecase({required this.repository});

  @override
  Future<Either<Failure, ProductModel>> call(int params) async => repository.getByIdProduct(params);
}
