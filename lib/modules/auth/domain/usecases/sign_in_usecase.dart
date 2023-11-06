import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../repositories/auth_repository.dart';
 

class SignInUsecase extends UseCase<void, SignInParams> {
  final AuthRepository repository;

  SignInUsecase({required this.repository});

  @override
  Future<Either<Failure, CurrentUser>> call(SignInParams params) =>
      repository.signIn(params.email, params.password);
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
