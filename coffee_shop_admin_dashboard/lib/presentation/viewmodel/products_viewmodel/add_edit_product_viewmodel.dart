import 'package:coffee_shop_admin_dashboard/domain/usecases/add_product_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/update_product_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

class AddEditProductViewModel extends Cubit<AddEditProductState> {
  final AddProductUsecase addProductUsecase;
  final UpdateProductUsecase updateProductUsecase;

  AddEditProductViewModel(this.addProductUsecase, this.updateProductUsecase)
    : super(const AddEditProductState());

  Future<void> saveProduct(Product product, bool isEditing) async {
    emit(state.copyWith(status: FormStatus.loading));

    final result = isEditing
        ? await updateProductUsecase.execute(product)
        : await addProductUsecase.execute(product);

    result.fold(
      (failure) => emit(
        state.copyWith(status: FormStatus.error, errorMessage: "Save Failed"),
      ),
      (_) => emit(state.copyWith(status: FormStatus.success)),
    );
  }
}
