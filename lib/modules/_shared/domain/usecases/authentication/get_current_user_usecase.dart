import '../../../domain/repositories/core_repository.dart';
import '../../entities/current_user.dart';

class GetCurrentUserUsecase {
  final CoreRepository repository;

  GetCurrentUserUsecase({required this.repository});

  Future<CurrentUser?> call() => repository.currentUser();
}
