import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import 'auth_navigator.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'presentation/cubit/sign_in_cubit.dart';
import 'presentation/pages/sign_in_page.dart';

class AuthModule extends Module {
  static const moduleName = '/auth';

  @override
  void binds(i) {
    i.addLazySingleton<AuthRemoteDatasource>(AuthRemoteDatasourceImpl.new);
    i.addLazySingleton<AuthLocalDatasource>(AuthLocalDatasourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<SignInUsecase>(SignInUsecase.new);
    i.addLazySingleton<AuthNavigator>(AuthNavigator.new);
    i.add<SignInCubit>(SignInCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child('/', child: (context) => const SignInPage());
    // r.child('/sign_up', child: (context) => const SignUpPage());
  }
}
