import '../../../domain/repositories/core_repository.dart';

class LogoutUsecase {
  final CoreRepository repository;

  LogoutUsecase({required this.repository});

  void call() {
     repository.logout();
  }
}

 
