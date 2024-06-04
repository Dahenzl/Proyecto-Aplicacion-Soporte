import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_client_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_client_repository.dart';

@GenerateMocks([
  IClientDataSource,
  IClientRepository,
  http.Client,
])

void main() {
  // Test code here
}