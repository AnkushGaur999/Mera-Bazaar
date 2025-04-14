import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

class GetUserProfileUseCase {
  final AuthenticationRepository authenticationRepository;

  GetUserProfileUseCase({required this.authenticationRepository});

  Future<DataState<GetUserProfileEntity>> call({required String token}) async {
    return await authenticationRepository.getUserProfile(token: token);
  }
}
