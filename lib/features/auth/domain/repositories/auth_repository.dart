import '../entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  });

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity?> getCurrentUser();
}
