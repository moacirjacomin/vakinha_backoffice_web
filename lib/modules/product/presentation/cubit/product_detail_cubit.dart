import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/domain/errors/failure.dart';
import '../../data/models/product_model.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final UpdateProductUsecase updateProductUsecase;
  final AddProductUsecase addProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final UploadFileUsecase uploadFileUsecase;

  ProductDetailCubit(
    this.updateProductUsecase,
    this.addProductUsecase,
    this.deleteProductUsecase,
    this.uploadFileUsecase,
  ) : super(ProductDetailState());

  void updateImagePath(String newImagePath){
    emit(state.copyWith(imagePath: newImagePath));
  }

  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    emit(state.copyWith(status: Status.loading));

    var result = await uploadFileUsecase(
      UploadFileUsecaseParams(file: file, filename: fileName)  );

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (imagePath) {
        print('... UPLOAD OK url=$imagePath');
        emit(state.copyWith(status: Status.initial, imagePath: imagePath));
        // loadProducts(state.filterName);
      },
    );
  }

  Future<void> save(ProductModel product) async {
      print('... CUBIT SAVE   product=$product  ');

      emit(state.copyWith(status: Status.loading));

      final result = product.id != null ? await updateProductUsecase(product) : await addProductUsecase(product);

      result.fold(
        (failure) {
          print('... ERROR: ${failure.getMessage()}');
          emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
        },
        (productList) {
          emit(state.copyWith(status: Status.success));
          // loadProducts(state.filterName);
        },
      );
  }

  Future<void> deleteProduct(int productId) async {
    emit(state.copyWith(status: Status.loading));
    final result = await deleteProductUsecase(productId);

    result.fold(
      (failure) {
        print('... ERROR: ${failure.getMessage()}');
        emit(state.copyWith(status: Status.failure, failure: failure, errorMessage: failure.getMessage()));
      },
      (productList) {
        emit(state.copyWith(status: Status.success));
      },
    );
  }
}
