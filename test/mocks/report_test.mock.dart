import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_report_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_report_repository.dart';

@GenerateMocks([
  IReportDataSource,
  IReportRepository,
  http.Client,
])

void main() {
  // Test code here
}