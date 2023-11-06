import 'dart:typed_data';
import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/product_repository.dart';

class UploadFileUsecase extends UseCase<String, UploadFileUsecaseParams> {
  final ProductRepository repository;

  UploadFileUsecase({required this.repository});

  @override
  Future<Either<Failure, String>> call(params) async => repository.uploadImageProduct(params.file, params.filename);
}

class UploadFileUsecaseParams {
  final Uint8List file;
  final String filename;

  UploadFileUsecaseParams({
    required this.file,
    required this.filename,
  });
}
