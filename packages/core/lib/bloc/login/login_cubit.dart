import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginInitial());
  final AuthRepository _authRepository;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      if (UtilFunctions.isEmailValid(email) && password.length >= 6) {
        await _authRepository.login(
          email: email,
          password: password,
        );
        emit(LoginSuccessful());
      } else {
        emit(const LoginError('Invalid email or password'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(const LoginError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(const LoginError('Wrong password provided for that user.'));
      }
    }
  }

  Future<void> signup({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      if (UtilFunctions.isEmailValid(email) && password.length >= 6) {
        await _authRepository.signup(
          email: email,
          password: password,
        );
        emit(RegistrationSuccess());
      } else {
        emit(const LoginError('Invalid email or password'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(const LoginError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const LoginError('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
      emit(LoginError(e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    emit(LoginLoading());
    try {
      await _authRepository.signInWithGoogle();
      emit(RegistrationSuccess());
    } catch (e) {
      print(e);
      emit(LoginError(e.toString()));
    }
  }
}
