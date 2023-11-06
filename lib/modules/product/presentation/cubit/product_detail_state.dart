part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;
  final ProductModel? product;
  final String imagePath;

  ProductDetailState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
    this.product,
    this.imagePath = '',
  });

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
        product,
        imagePath
      ];

  ProductDetailState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
    ProductModel? productList,
    String? filterName,
    String? imagePath,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
