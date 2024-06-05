import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_authentication_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_authentication_repository.dart';

@GenerateMocks([
  IAuthenticationDataSource,
  IAuthenticationRepository,
  http.Client,
])

void main() {
  // Test code here
}