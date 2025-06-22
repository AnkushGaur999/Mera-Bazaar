import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

class UserLoginUseCase {
  final AuthenticationRepository authRepository;

  UserLoginUseCase({required this.authRepository});

  Future<DataState<User>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.login(email: email, password: password);
  }
}
