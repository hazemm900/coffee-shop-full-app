part of 'products_viewmodel.dart';

enum ViewStatus { initial, loading, success, error }

class ProductsState extends Equatable {
  final ViewStatus status;
  final List<Product> products;
  final String? errorMessage;

  const ProductsState({
    this.status = ViewStatus.initial,
    this.products = const [],
    this.errorMessage,
  });

  ProductsState copyWith({
    ViewStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
