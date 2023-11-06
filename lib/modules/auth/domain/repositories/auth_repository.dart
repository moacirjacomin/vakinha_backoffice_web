import 'package:dartz/dartz.dart';

import '../../../_shared/domain/entities/current_user.dart';
import '../../../_shared/domain/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, CurrentUser>> signIn(String email, String password);
  Future<Either<Failure, CurrentUser>> signUp(String name, String email, String password, String type);
}
