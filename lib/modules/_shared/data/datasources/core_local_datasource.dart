import '../../domain/entities/current_user.dart';
import '../storage/base_storage.dart';

abstract class CoreLocalDataSource {
  bool isDarkMode();

  void toggleDarkMode();

  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);

  void logout();
}

class CoreLocalDataSourceImpl implements CoreLocalDataSource {
  final BaseStorage localStorage;
  CoreLocalDataSourceImpl(
    this.localStorage,
  );

  @override
  bool isDarkMode() {
    return localStorage.getBool('isDarkMode') ?? false;
  }

  @override
  void toggleDarkMode() {
    bool currentValue = isDarkMode();
    localStorage.setBool('isDarkMode', !currentValue);
  }

  @override
  Future<CurrentUser?> currentUser() async {
    final currentUserJson = localStorage.getString('currentUser');

    if (currentUserJson == null) return null;

    final currentUser = CurrentUser.fromJson(currentUserJson);
    return currentUser;
  }

  @override
  Future<void> updateCurrentUser(CurrentUser currentUser) async {
    await localStorage.setString('currentUser', currentUser.toJson());
  }

  @override
  void logout() async {
    // await localStorage.clear();
     print('... CORE DATASOURCE');
    localStorage.remove('currentUser');
  }
}
