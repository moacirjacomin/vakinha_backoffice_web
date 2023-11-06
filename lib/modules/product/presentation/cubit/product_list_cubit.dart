import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../../_shared/shared_navigator.dart';
import '../../data/models/product_model.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final UpdateProductUsecase updateProductUsecase;
  final AddProductUsecase addProductUsecase;
  final GetProductUsecase getProductUsecase;
  final SharedNavigator sharedNavigator;

  ProductListCubit(
    this.updateProductUsecase,
    this.getProductUsecase,
    this.addProductUsecase,
    this.sharedNavigator,
  ) : super(ProductListState(productList: []));

  onInit(){
    loadProducts(null);
  }

  Future<void> onChangeFilter(String newValue) async {
      print('... filter value=$newValue');
      loadProducts(newValue);
  }


   
  
  Future<void> addOrUpdateProduct(ProductModel product, bool isUpdate) async {
    print('... CUBIT product isUpdate=$isUpdate product=${product}');

    emit(state.copyWith(status: Status.loading));
 

    // if() UpdateProductUsecase
    final result = isUpdate ? await updateProductUsecase(product) : await addProductUsecase(product);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (productList) {
        // emit(state.copyWith(status: Status.success));
        loadProducts(state.filterName); 
      },
    );
  }

  Future loadProducts(String? nameFilter) async {
    emit(state.copyWith(status: Status.loading));
    final result = await getProductUsecase(nameFilter);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (productList) {
        emit(state.copyWith(status: Status.success, productList: productList, filterName: nameFilter));
      },
    );
  }



  // Future delete(int productId) async {
  //   emit(state.copyWith(status: Status.loading));
  //   final result = await deleteProductUsecase(productId);

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
  //     },
  //     (user) {
  //       emit(state.copyWith(status: Status.success));
  //     },
  //   );
  // }
}
