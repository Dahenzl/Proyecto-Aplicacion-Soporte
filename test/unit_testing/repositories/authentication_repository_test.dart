import 'package:proyecto_aplicacion_soporte/data/repositories/authentication_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/authentication_test.mock.mocks.dart';

void main() {
  late AuthenticationRepository authRepository;
  late MockIAuthenticationDataSource mockAuthDataSource;

  setUp(() {
    mockAuthDataSource = MockIAuthenticationDataSource();
    authRepository = AuthenticationRepository(mockAuthDataSource);
  });

  group('AuthRepository Tests', () {
    test('login should forward the login call to the data source', () async {
      // Arrange
      String email = 'test@example.com';
      String password = 'password123';
      when(mockAuthDataSource.login(email, password)).thenAnswer((_) async => (1, 'support'));

      // Act
      var result = await authRepository.login(email, password);

      // Assert
      verify(mockAuthDataSource.login(email, password)).called(1);
      expect(result, equals((1, 'support')));
    });

    test('logOut should forward the logOut call to the data source', () async {
      // Arrange
      when(mockAuthDataSource.logOut()).thenAnswer((_) async => true);

      // Act
      var result = await authRepository.logOut();

      // Assert
      verify(mockAuthDataSource.logOut()).called(1);
      expect(result, isTrue);
    });
  });
}
