import '../entities/current_user.dart';

abstract class CoreRepository {
  bool isDarkTheme();

  void toggleDarkTheme();

  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);

  void logout();
}