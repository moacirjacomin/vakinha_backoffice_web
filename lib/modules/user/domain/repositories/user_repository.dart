import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getByIdUser(int id);
  Future<UserModel> getByIdUserDirect(int id);
}
