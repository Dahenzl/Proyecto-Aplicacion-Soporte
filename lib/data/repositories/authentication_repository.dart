import 'package:proyecto_aplicacion_soporte/data/datasources/remote/authentication_datasource.dart';

class AuthenticationRepository {
  late AuthenticationDataSource _authenticationDataSource;

  AuthenticationRepository() {
    _authenticationDataSource = AuthenticationDataSource();
  }

  Future<(int, String)> login(String email, String password) async =>
      await _authenticationDataSource.login(email, password);

  Future<bool> logOut() async => await _authenticationDataSource.logOut();
}
