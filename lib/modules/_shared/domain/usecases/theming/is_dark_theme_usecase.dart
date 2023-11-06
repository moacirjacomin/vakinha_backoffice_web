import '../../../domain/repositories/core_repository.dart';

class IsDarkThemeUseCase {
  final CoreRepository repository;

  IsDarkThemeUseCase({required this.repository});

  bool call() => repository.isDarkTheme();
}
