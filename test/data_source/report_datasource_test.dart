import 'package:proyecto_aplicacion_soporte/data/datasources/remote/report_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../mocks/report_test.mock.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ReportDataSource dataSource;
  const String apiKey = 'Z05bVs';

  group('ReportDataSource Tests', () {

    const String reportJson =
        '[{"id":1,"title":"reporte1","rating":5.0,"user_id":1,"duration":95,"start_time":452,"support_id":1,"description":"mi descripción"},{"id":2,"title":"reporte1","rating":4.5,"user_id":2,"start_time":254,"duration":95,"support_id":2,"description":"mi descripción de nuevo"}]';

    final MockClient mockClient = MockClient();

    dataSource = ReportDataSource(client: mockClient);

    test('getReports returns a list of reports on a successful call', () async {

      var request = Uri.parse("https://retoolapi.dev/$apiKey/reports");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response(reportJson, 200));

      final result = await dataSource.getReports();

      expect(result, isA<List<Report>>());

      expect(result.first.title, equals('reporte1'));
    });

    test('getReports throws an exception on a failed call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/reports");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dataSource.getReports(), throwsException);
    });
  });
}
