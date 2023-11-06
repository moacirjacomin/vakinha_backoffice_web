import 'package:dartz/dartz.dart';

import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/domain/usecases/base_usecase.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetOneUserUsecase extends UseCase<UserModel, int> { // UserDto
  final UserRepository userRepository; 
 

  GetOneUserUsecase({
    required this.userRepository, 
  });

  @override
  Future<Either<Failure, UserModel>> call(int params) async =>  await userRepository.getByIdUser(params)  ;

   
}


