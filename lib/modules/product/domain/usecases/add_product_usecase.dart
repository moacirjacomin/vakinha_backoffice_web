import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase extends UseCase<void, ProductModel> {
  final ProductRepository repository;

  AddProductUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ProductModel params) async => repository.addProduct(params);
}
