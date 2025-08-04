import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUser {
  final AuthRepository repository;

  GetLoggedInUser(this.repository);

  Future<UserEntity?> call() {
    return repository.getCurrentUser();
  }
}
