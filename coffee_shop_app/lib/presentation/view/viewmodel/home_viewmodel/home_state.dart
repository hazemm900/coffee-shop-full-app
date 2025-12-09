part of 'home_viewmodel.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String? errorMessage;
  final bool isLogoutLoading;
  final bool isLogoutSuccess;

  const HomeState({
    this.status = HomeStatus.initial,
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.categories = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.errorMessage,
    this.isLogoutLoading = false,
    this.isLogoutSuccess = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
    bool? isLogoutLoading,
    bool? isLogoutSuccess,
  }) {
    return HomeState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      isLogoutLoading: isLogoutLoading ?? this.isLogoutLoading,
      isLogoutSuccess: isLogoutSuccess ?? this.isLogoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allProducts,
    filteredProducts,
    categories,
    selectedCategory,
    searchQuery,
    errorMessage,
    isLogoutLoading,
    isLogoutSuccess,
  ];
}
