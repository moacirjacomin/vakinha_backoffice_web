import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/payment_remote_datasource.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'domain/repositories/payment_repository.dart';
import 'domain/usecases/add_payment_type_usecase.dart';
import 'domain/usecases/get_one_payment_type_usecase.dart';
import 'domain/usecases/get_payment_type_usecase.dart';
import 'domain/usecases/update_payment_type_usecase.dart';
import 'presentation/cubit/payment_type_cubit.dart';
import 'presentation/pages/payment_type_page.dart';

class PaymentModule extends Module {
  static const moduleName = '/payment';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<PaymentRemoteDatasource>(PaymentRemoteDatasourceImpl.new);
    i.addLazySingleton<PaymentRepository>(PaymentRepositoryImpl.new);
    i.addLazySingleton<GetPaymentTypeUsecase>(GetPaymentTypeUsecase.new);
    i.addLazySingleton<GetOnePaymentTypeUsecase>(GetOnePaymentTypeUsecase.new);
    i.addLazySingleton<AddPaymentTypeUsecase>(AddPaymentTypeUsecase.new);
    i.addLazySingleton<UpdatePaymentTypeUsecase>(UpdatePaymentTypeUsecase.new);
    i.add<PaymentTypeCubit>(PaymentTypeCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => PaymentTypePage());
    // r.module('/', module: SplashModule());
    // r.module('/home', module: HomeModule());
    // r.module('/auth', module: AuthModule());
  }
}
