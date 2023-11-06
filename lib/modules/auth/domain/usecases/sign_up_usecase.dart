import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/auth_repository.dart';

class SignUpUsecase extends UseCase<void, SignUpParams> {
  final AuthRepository repository;

  SignUpUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(SignUpParams params) => repository.signUp(
        params.name,
        params.email,
        params.password,
        params.type,
      );
}

class SignUpParams {
  final String email;
  final String password;
  final String name;
  final String type;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.type,
  });
}
