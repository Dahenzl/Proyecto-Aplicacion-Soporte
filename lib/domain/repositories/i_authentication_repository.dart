import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_authentication_datasource.dart';

abstract class IAuthenticationRepository {
  late IAuthenticationDataSource _authenticationDataSource;

  IAuthenticationRepository(this._authenticationDataSource);

  Future<(int, String)> login(String email, String password);

  Future<bool> logOut();
}
