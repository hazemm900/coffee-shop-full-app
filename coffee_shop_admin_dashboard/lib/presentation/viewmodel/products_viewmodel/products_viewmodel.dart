import 'package:coffee_shop_admin_dashboard/domain/usecases/delete_product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';
import '../../../domain/usecases/get_products_usecase.dart';

part 'products_state.dart';

class ProductsViewModel extends Cubit<ProductsState> {
  final GetProductsUsecase getProductsUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductsViewModel(this.getProductsUsecase, this.deleteProductUsecase)
    : super(const ProductsState()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (isClosed) return;
    emit(state.copyWith(status: ViewStatus.loading));

    final result = await getProductsUsecase.execute();

    if (isClosed) return;
    result.fold(
      (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: ViewStatus.error,
              errorMessage: "Error fetching data",
            ),
          );
        }
      },
      (products) {
        if (!isClosed) {
          emit(state.copyWith(status: ViewStatus.success, products: products));
        }
      },
    );
  }

  Future<void> removeProduct(String productId) async {
    final result = await deleteProductUsecase.execute(productId);
    result.fold(
      (failure) {
        // ممكن تعرض Snackbar أو رسالة خطأ هنا
      },
      (_) async {
        // بعد الحذف الناجح، أعد تحميل المنتجات
        await fetchProducts();
      },
    );
  }
}
