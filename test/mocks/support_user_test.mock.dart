import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_support_user_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_support_user_repository.dart';

@GenerateMocks([ISupportUserRepository])
@GenerateMocks([ISupportUserDataSource])
@GenerateMocks([http.Client])

void main() {
  // Test code here
}