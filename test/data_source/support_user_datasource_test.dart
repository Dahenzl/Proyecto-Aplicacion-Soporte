import 'package:proyecto_aplicacion_soporte/data/datasources/remote/support_user_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../mocks/support_user_test.mock.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late SupportUserDataSource dataSource;
  const String apiKey = 'tRq1YZ';

  group('SupportUserDataSource Tests', () {
    const String supportUserJson =
        '[{"id":1,"first_name":"John","last_name":"Doe","email":"john.doe@example.com","password":"contraseña123"},{"id":2,"first_name":"John","last_name":"Doe","email":"john.doe@example.com","password":"contraseña123"}]';

    final MockClient mockClient = MockClient();

    dataSource = SupportUserDataSource(client: mockClient);

    test('getSupportUsers returns a list of support users on a successful call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response(supportUserJson, 200));

      final result = await dataSource.getSupportUsers();

      expect(result, isA<List<SupportUser>>());

      expect(result.first.firstName, equals('John'));
    });

    test('getSupportUsers throws an exception on a failed call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dataSource.getSupportUsers(), throwsException);
    });
  });
}
