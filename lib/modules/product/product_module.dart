import 'package:flutter_modular/flutter_modular.dart';

import '../../app_module.dart';
import '../_shared/data/error_report/errors_report.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/add_product_usecase.dart';
import 'domain/usecases/delete_product_usecase.dart';
import 'domain/usecases/get_product_usecase.dart';
import 'domain/usecases/update_product_usecase.dart';
import 'domain/usecases/upload_file_usecase.dart';
import 'presentation/cubit/product_detail_cubit.dart';
import 'presentation/cubit/product_list_cubit.dart';
import 'presentation/pages/product_detail_page.dart';
import 'presentation/pages/product_list_page.dart';

class ProductModule extends Module {
  static const moduleName = '/product';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.add<ErrorsReport>(ErrorsReportImpl.new);
    i.addLazySingleton<ProductRemoteDatasource>(ProductRemoteDatasourceImpl.new);
    i.addLazySingleton<ProductRepository>(ProductRepositoryImpl.new);
    i.addLazySingleton<GetProductUsecase>(GetProductUsecase.new);
    i.addLazySingleton<UpdateProductUsecase>(UpdateProductUsecase.new);
    i.addLazySingleton<AddProductUsecase>(AddProductUsecase.new);
    i.addLazySingleton<DeleteProductUsecase>(DeleteProductUsecase.new);
    i.addLazySingleton<UploadFileUsecase>(UploadFileUsecase.new);
    i.add<ProductListCubit>(ProductListCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
    i.add<ProductDetailCubit>(ProductDetailCubit.new, config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => ProductListPage());
    r.child('/detail', child: (context) => ProductDetailPage(productId: null,));
  }
}
