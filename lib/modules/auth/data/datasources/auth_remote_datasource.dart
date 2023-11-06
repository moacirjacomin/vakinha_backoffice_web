import 'dart:convert';

import '../../../_shared/data/network/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../../../_shared/domain/entities/current_user.dart';

abstract class AuthRemoteDatasource {
  Future<CurrentUser> signIn(String email, String password);
  Future<CurrentUser> signUp(String name, String email, String password, String type);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  // final NotLoggedDio notLoggedDio;
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const AuthRemoteDatasourceImpl({
    // required this.notLoggedDio,
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<CurrentUser> signIn(String email, String password) async {
    print('... DATA SOURCE email=$email password=$password');
    var result = await loggedDio.post(
      appNetwork.signIn, // /auth
      data: {
        'email': email,
        'password': password,
        'admin': true,
      },
    );

    print('... DATA SOURCE result.data=${result.data}');

    return CurrentUser.fromMap(result.data);
  }

  @override
  Future<CurrentUser> signUp(String name, String email, String password, String type) async {
    print('... signIn  ');
    String fakeData = '''
      {
        "id": "adadadsadasd",
        "name": "Roberto Logado",
        "email": "roberto@teste.com",
        "avatar":"https://xsgames.co/randomusers/avatar.php?g=male",
        "type": "customer"
      }
      ''';

    final fakeJson = json.decode(fakeData);
    return CurrentUser.fromJson(fakeJson);
  }
}
