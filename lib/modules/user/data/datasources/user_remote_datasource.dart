import '../../../_shared/data/network/app_network.dart';
import '../../../_shared/data/network/logged_dio.dart';
import '../models/user_model.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getByIdUser(int id);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final LoggedDio loggedDio;
  final AppNetwork appNetwork;

  const UserRemoteDatasourceImpl({
    required this.loggedDio,
    required this.appNetwork,
  });

  @override
  Future<UserModel> getByIdUser(int id) async {
    print('... DATA SOURCE getByIdUser   id=$id');
    var result = await loggedDio.get(appNetwork.user + '/$id');

    print('... DATA SOURCE result.data=${result.data}');

    return UserModel.fromMap(result.data);
  }
}
