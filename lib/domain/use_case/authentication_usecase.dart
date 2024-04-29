import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/support_user.dart';
import '../repositories/i_authentication_repository.dart';

class AuthenticationUseCase {
  final IAuthenticationRepository _authenticationRepository = Get.find();

  AuthenticationUseCase();

  Future<(int, String)> login(String email, String password) async =>
      await _authenticationRepository.login(email, password);

  Future<bool> logOut() async => await _authenticationRepository.logOut();
}
