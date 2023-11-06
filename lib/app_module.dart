import 'package:flutter_modular/flutter_modular.dart';

import 'modules/_layout/base_layout.dart';
import 'modules/_shared/data/datasources/core_local_datasource.dart';
import 'modules/_shared/data/error_report/errors_report.dart';
import 'modules/_shared/data/network/app_network.dart';
import 'modules/_shared/data/network/logged_dio.dart';
import 'modules/_shared/data/network/logged_interceptor.dart';
import 'modules/_shared/data/network/not_logged_dio.dart';
import 'modules/_shared/data/network/not_logged_interceptor.dart';
import 'modules/_shared/data/repositories/core_repository_impl.dart';
import 'modules/_shared/data/storage/base_storage.dart';
import 'modules/_shared/data/storage/local_storage.dart';
import 'modules/_shared/data/storage/local_storage_session.dart';
import 'modules/_shared/domain/repositories/core_repository.dart';
import 'modules/_shared/domain/usecases/authentication/get_current_user_usecase.dart';
import 'modules/_shared/domain/usecases/authentication/logout_usecase.dart';
import 'modules/_shared/domain/usecases/authentication/update_auth_user_usecase.dart';
import 'modules/_shared/presentation/widgets/not_found_page.dart';
import 'modules/_shared/shared_navigator.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/order/order_module.dart';
import 'modules/payment/payment_module.dart';
import 'modules/product/product_module.dart';

final class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) => i
    ..add<AppNetwork>(() => AppNetwork())
    ..add<ErrorsReport>(ErrorsReportImpl.new)
    ..addSingleton<BaseStorage>(() => LocalStorageSession.getInstance())
    ..addLazySingleton<SharedNavigator>(SharedNavigator.new)
    ..addLazySingleton<LocalStorageSecure>(() => LocalStorageSecure.getInstance())
    ..addSingleton<CoreLocalDataSource>(CoreLocalDataSourceImpl.new)
    ..addSingleton<CoreRepository>(CoreRepositoryImpl.new)
    ..addSingleton<GetCurrentUserUsecase>(GetCurrentUserUsecase.new)
    ..addSingleton<UpdateCurrentUserUsecase>(UpdateCurrentUserUsecase.new)
    ..addSingleton<LogoutUsecase>(LogoutUsecase.new)
    ..addSingleton<NotLoggedInterceptor>(NotLoggedInterceptor.new)
    ..addSingleton<LoggedInterceptor>(LoggedInterceptor.new)
    ..addSingleton<LoggedDio>(LoggedDio.new)
    ..addSingleton<NotLoggedDio>(NotLoggedDio.new);
}

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
  }

  @override
  void routes(r) {
    r.module('/auth', module: AuthModule()); 
    r.child('/',
        child: (context) => BaseLayout(
              body: RouterOutlet(),
            ),
        transition: TransitionType.leftToRight,
        children: [
          ModuleRoute('/home', module: HomeModule()),
          ModuleRoute('/payment', module: PaymentModule()),
          ModuleRoute('/product', module: ProductModule()),
          ModuleRoute('/order', module: OrderModule()),
          // WildcardRoute(child: (context) => NotFoundPage()),
        ]);
  }
}
