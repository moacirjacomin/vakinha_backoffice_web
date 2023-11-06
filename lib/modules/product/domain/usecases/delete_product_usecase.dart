import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase extends UseCase<void, int> {
  final ProductRepository repository;

  DeleteProductUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(int params) async => repository.deleteProduct(params);
}
