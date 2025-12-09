import 'package:coffee_shop_app/domain/usecases/get_categories_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_products_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

part 'home_state.dart';

class HomeViewModel extends Cubit<HomeState> {
  final GetProductsUsecase getProductsUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final LogoutUsecase logoutUsecase;

  HomeViewModel(
    this.getProductsUsecase,
    this.getCategoriesUsecase,
    this.logoutUsecase,
  ) : super(const HomeState()) {
    loadData();
  }

  Future<void> loadData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final productsResult = await getProductsUsecase.execute();
    final categoriesResult = await getCategoriesUsecase.execute();

    productsResult.fold(
      (failure) => emit(
        state.copyWith(status: HomeStatus.error, errorMessage: failure.message),
      ),
      (products) {
        categoriesResult.fold(
          (failure) => emit(
            state.copyWith(
              status: HomeStatus.error,
              errorMessage: failure.message,
            ),
          ),
          (categories) {
            emit(
              state.copyWith(
                status: HomeStatus.success,
                allProducts: products,
                filteredProducts: products,
                categories: ["All", ...categories], // نضيف All كـ Default
              ),
            );
          },
        );
      },
    );
  }

  void _filterProducts() {
    List<Product> products = List.from(state.allProducts);

    if (state.selectedCategory != 'All') {
      products = products
          .where((p) => p.category == state.selectedCategory)
          .toList();
    }

    if (state.searchQuery.isNotEmpty) {
      products = products
          .where(
            (p) =>
                p.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
    }

    emit(state.copyWith(filteredProducts: products));
  }

  void onCategorySelected(String category) {
    emit(state.copyWith(selectedCategory: category));
    _filterProducts();
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
    _filterProducts();
  }

  Future<void> performLogout() async {
    emit(state.copyWith(isLogoutLoading: true));
    final result = await logoutUsecase.execute();

    result.fold(
      (failure) => emit(state.copyWith(isLogoutLoading: false)),
      (_) =>
          emit(state.copyWith(isLogoutLoading: false, isLogoutSuccess: true)),
    );
  }

  Future<void> reloadData() async {
    // إعادة تحميل نفس الداتا — افصل retry logic لو حبيت
    await loadData();
  }
}
