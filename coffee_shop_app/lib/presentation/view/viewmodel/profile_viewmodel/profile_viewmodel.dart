import 'package:coffee_shop_app/domain/usecases/get_user_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/user.dart';

part 'profile_state.dart';

class ProfileViewModel extends Cubit<ProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;

  ProfileViewModel(this.getUserProfileUsecase) : super(ProfileInitial()) {
    fetchUserProfile(); // استدعاء الدالة مباشرة عند إنشاء الـ ViewModel
  }

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    final result = await getUserProfileUsecase.execute();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}
