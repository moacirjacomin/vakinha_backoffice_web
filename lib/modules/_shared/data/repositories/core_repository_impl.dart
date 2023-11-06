import '../../domain/entities/current_user.dart';
import '../../domain/repositories/core_repository.dart';
import '../datasources/core_local_datasource.dart';

class CoreRepositoryImpl implements CoreRepository {
  final CoreLocalDataSource localDataSource;

  CoreRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<CurrentUser?> currentUser() => localDataSource.currentUser();

  @override
  bool isDarkTheme() => localDataSource.isDarkMode();

  @override
  void toggleDarkTheme() => localDataSource.toggleDarkMode();

  @override
  void updateCurrentUser(CurrentUser currentUser) => localDataSource.updateCurrentUser(currentUser);

  @override
  void logout() => localDataSource.logout();
}
