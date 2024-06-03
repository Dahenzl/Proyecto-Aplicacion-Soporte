import 'package:proyecto_aplicacion_soporte/data/datasources/remote/authentication_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;
  AuthenticationRepository(this._authenticationDataSource);

  @override
  Future<(int, String)> login(String email, String password) async =>
      await _authenticationDataSource.login(email, password);

  @override
  Future<bool> logOut() async => await _authenticationDataSource.logOut();
}
