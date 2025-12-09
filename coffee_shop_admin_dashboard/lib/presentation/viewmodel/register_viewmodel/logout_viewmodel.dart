import 'package:bloc/bloc.dart';
import '../../../../domain/usecases/logout_usecase.dart';

part 'logout_state.dart';

class LogoutViewModel extends Cubit<LogoutState> {
  final LogoutUsecase logoutUsecase;

  LogoutViewModel(this.logoutUsecase) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await logoutUsecase.execute();
    result.fold(
      (failure) => emit(LogoutError(failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
