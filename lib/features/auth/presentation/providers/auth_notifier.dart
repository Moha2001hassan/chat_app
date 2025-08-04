import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_logged_in_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUser _registerUser;
  final LoginUser _loginUser;
  final GetLoggedInUser _getLoggedInUser;

  AuthNotifier(this._registerUser, this._loginUser, this._getLoggedInUser)
    : super(AuthInitial());

  Future<AuthState> register(UserModel user, String password) async {
    state = AuthLoading();
    try {
      final registeredUser = await _registerUser.call(
        name: user.name,
        phone: user.phone,
        email: user.email,
        image: user.image,
        password: password,
      );
      state = Authenticated(registeredUser);
      return Authenticated(registeredUser);
    } catch (e) {
      state = AuthError(e.toString());
      return AuthError(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthLoading();
    try {
      final user = await _loginUser.call(email: email, password: password);
      state = Authenticated(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> getLoggedInUser() async {
    state = AuthLoading();
    try {
      final user = await _getLoggedInUser.call();
      if (user != null) {
        state = Authenticated(user);
      } else {
        state = Unauthenticated();
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  void logout() {
    // احذف التوكن أو أي بيانات محفوظة إذا أردت
    state = Unauthenticated();
  }
}
