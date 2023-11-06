import '../../../domain/repositories/core_repository.dart';
import '../../entities/current_user.dart';

class UpdateCurrentUserUsecase {
  final CoreRepository repository;

  UpdateCurrentUserUsecase({required this.repository});

  void call(CurrentUser currentUser) {
     repository.updateCurrentUser(currentUser);
  }
}
