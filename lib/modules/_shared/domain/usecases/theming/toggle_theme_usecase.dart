import '../../../domain/repositories/core_repository.dart';

class ToggleThemeUseCase {
  final CoreRepository repository;

  ToggleThemeUseCase({required this.repository});

  void call() => repository.toggleDarkTheme();
}
