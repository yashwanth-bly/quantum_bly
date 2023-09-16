import 'package:core/core.dart';

part 'app_core_state.dart';

class AppCoreCubit extends Cubit<AppCoreState> {
  AppCoreCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AppCoreInitial());
  final AuthRepository _authRepository;
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      emit(AppCoreLogout());
    } catch (e) {
      emit(AppCoreLogoutError());
    }
  }
}
