import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import '../payment/data/datasources/payment_remote_datasource.dart';
import '../payment/data/repositories/payment_repository_impl.dart';
import '../payment/domain/repositories/payment_repository.dart';
import '../product/data/datasources/product_remote_datasource.dart';
import '../product/data/repositories/product_repository_impl.dart';
import '../product/domain/repositories/product_repository.dart';
import '../user/data/datasources/user_remote_datasource.dart';
import '../user/data/repositories/user_repository_impl.dart';
import '../user/domain/repositories/user_repository.dart';
import 'data/datasources/order_remote_datasource.dart';
import 'data/repositories/order_repository_impl.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/usecases/get_one_order_type_usecase.dart';
import 'domain/usecases/get_order_usecase.dart';
import 'domain/usecases/update_order_usecase.dart';
import 'domain/usecases/update_status_order_usecase.dart';
import 'presentation/cubit/order_list_cubit.dart';
import 'presentation/pages/order_list_page.dart';

class OrderModule extends Module {
  static const moduleName = '/order';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<OrderRemoteDatasource>(OrderRemoteDatasourceImpl.new);
    i.addLazySingleton<OrderRepository>(OrderRepositoryImpl.new);

    i.addLazySingleton<PaymentRemoteDatasource>(PaymentRemoteDatasourceImpl.new);
    i.addLazySingleton<PaymentRepository>(PaymentRepositoryImpl.new);

    i.addLazySingleton<UserRemoteDatasource>(UserRemoteDatasourceImpl.new);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);

    i.addLazySingleton<ProductRemoteDatasource>(ProductRemoteDatasourceImpl.new);
    i.addLazySingleton<ProductRepository>(ProductRepositoryImpl.new);

    i.addLazySingleton<GetOneOrderUsecase>(GetOneOrderUsecase.new);
    i.addLazySingleton<GetOrderUsecase>(GetOrderUsecase.new);
    i.addLazySingleton<UpdateOrderUsecase>(UpdateOrderUsecase.new);
    i.addLazySingleton<UpdateStatusOrderUsecase>(UpdateStatusOrderUsecase.new);

    i.add<OrderListCubit>(OrderListCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => OrderListPage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}
