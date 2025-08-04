import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/get_logged_in_user.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(registerUserProvider),
    ref.watch(loginUserProvider),
    ref.watch(getLoggedInUserProvider),
  );
});
//___________________________________________

// Auth datasource
final authDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource();
});

// Repository
final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(ref.watch(authDatasourceProvider));
});

// Use Cases
final registerUserProvider = Provider((ref) {
  return RegisterUser(ref.watch(authRepositoryProvider));
});

final loginUserProvider = Provider((ref) {
  return LoginUser(ref.watch(authRepositoryProvider));
});

final getLoggedInUserProvider = Provider((ref) {
  return GetLoggedInUser(ref.watch(authRepositoryProvider));
});

// Current user state
final authStateProvider = FutureProvider((ref) async {
  return ref.watch(getLoggedInUserProvider).call();
});
