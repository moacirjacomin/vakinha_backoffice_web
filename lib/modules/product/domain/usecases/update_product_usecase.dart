import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase extends UseCase<void, ProductModel> {
  final ProductRepository repository;

  UpdateProductUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ProductModel params) async => repository.updateProduct(params);
}
