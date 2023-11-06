part of 'product_list_cubit.dart';

class ProductListState extends Equatable {
  final Status status;
  final Failure? failure;
  final String? errorMessage;
  final List<ProductModel> productList;
  final String? filterName;

  ProductListState({
    this.status = Status.initial,
    this.failure,
    this.errorMessage = '',
    this.productList = const [],
    this.filterName,
  });

  @override
  List<Object?> get props => [
        status,
        failure,
        errorMessage,
        productList,
        filterName,
      ];

  ProductListState copyWith({
    Status? status,
    Failure? failure,
    String? errorMessage,
    List<ProductModel>? productList,
    String? filterName,
  }) {
    return ProductListState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      productList: productList ?? this.productList,
      filterName: filterName ?? this.filterName,
    );
  }
}
