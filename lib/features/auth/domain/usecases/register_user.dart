import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserEntity> call({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) {
    return repository.register(
      name: name,
      phone: phone,
      email: email,
      password: password,
      image: image,
    );
  }
}
