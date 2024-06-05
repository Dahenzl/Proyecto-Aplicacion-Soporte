import 'package:proyecto_aplicacion_soporte/data/datasources/remote/authentication_datasource.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../mocks/authentication_test.mock.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthenticationDataSource dataSource;
  const String apiKey = 'tRq1YZ';

  group('AuthenticationDataSource Tests', () {
    const String supportUserJson =
        '[{"id":1,"first_name":"John","last_name":"Doe","email":"john.doe@example.com","password":"contraseña123"},{"id":2,"first_name":"Alice","last_name":"Smith","email":"alice.smith@example.com","password":"contraseña1234"}]';

    final MockClient mockClient = MockClient();

    dataSource = AuthenticationDataSource(client: mockClient);

    test('getSupportUsers returns a list of support users on a successful call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response(supportUserJson, 200));

      final result = await dataSource.getSupportUsers();

      expect(result, isA<List<SupportUser>>());
      expect(result.first.firstName, equals('Alice'));
    });

    test('getSupportUsers throws an exception on a failed call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(dataSource.getSupportUsers(), throwsException);
    });

    test('login returns correct user id and role for valid credentials', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response(supportUserJson, 200));

      final result2 = await dataSource.login('alice.smith@example.com', 'contraseña1234');
      expect(result2, equals((2, 'support')));

      final result3 = await dataSource.login('a@a.com', '123456');
      expect(result3, equals((1, 'coordinator')));

      final result4 = await dataSource.login('b@a.com', '123456');
      expect(result4, equals((2, 'coordinator')));
    });

    test('login throws an exception for invalid credentials', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/support");

      when(mockClient.get(request, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}))
          .thenAnswer((_) async => http.Response(supportUserJson, 200));

      expect(() async => await dataSource.login('invalid@example.com', 'wrongpassword'), throwsException);
    });

    test('logOut always returns false', () async {
      final result = await dataSource.logOut();
      expect(result, isFalse);
    });
  });
}