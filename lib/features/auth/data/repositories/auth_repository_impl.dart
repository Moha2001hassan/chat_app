import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    final model = await datasource.login(email: email, password: password);
    return model;
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) async {
    final model = await datasource.register(
      name: name,
      phone: phone,
      email: email,
      password: password,
      image: image,
    );
    return model;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final model = await datasource.getCurrentUser();
    return model;
  }
}
