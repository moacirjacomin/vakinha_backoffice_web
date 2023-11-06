import '../../../_shared/data/storage/base_storage.dart';
import '../../../_shared/domain/entities/current_user.dart';

abstract class AuthLocalDatasource {
  Future<CurrentUser?> currentUser();

  void updateCurrentUser(CurrentUser currentUser);
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  // final NotLoggedDio notLoggedDio;
  final BaseStorage localStorage;

  const AuthLocalDatasourceImpl({
    required this.localStorage,
  });

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
    await localStorage.setString('access_token', currentUser.token!);
  }
}
