import 'package:proyecto_aplicacion_soporte/data/datasources/remote/client_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../mocks/client_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ClientDataSource dataSource;
  const String apiKey = 'f0yCMk';

  group('ClientDataSource Tests', () {
    final Uri clientUri = Uri.parse('https://retoolapi.dev/$apiKey/users');
    const String clientJson =
        '[{"id":1,"firstName":"John","lastName":"Doe","email":"john.doe@example.com"},{"id":2,"firstName":"John","lastName":"Doe","email":"john.doe@example.com"}]';
    final MockClient mockClient = MockClient();
    dataSource = ClientDataSource(client: mockClient);
    test('getClients returns a list of users on a sucessfull call', () async {
      var request =
          clientUri.resolveUri(Uri(queryParameters: {"format": "json"}));
      when(mockClient.get(request))
          .thenAnswer((_) async => http.Response(clientJson, 200));
      final result = await dataSource.getClients();
      expect(result, isA<List<Client>>());
      expect(result.first.firstName, equals('John'));
    });

    test('getClients throws an exception on a failed call', () async {
      var request =
          clientUri.resolveUri(Uri(queryParameters: {"format": "json"}));
      when(mockClient.get(request))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(dataSource.getClients(), throwsException);
    });
  });
}
