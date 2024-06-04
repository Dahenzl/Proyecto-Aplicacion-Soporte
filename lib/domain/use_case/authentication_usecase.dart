import '../repositories/i_authentication_repository.dart';

class AuthenticationUseCase {
  final IAuthenticationRepository _authenticationRepository;

  AuthenticationUseCase(this._authenticationRepository);

  Future<(int, String)> login(String email, String password) async =>
      await _authenticationRepository.login(email, password);

  Future<bool> logOut() async => await _authenticationRepository.logOut();
}
