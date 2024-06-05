import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/authentication_usecase.dart';
import '../../mocks/authentication_test.mock.mocks.dart';

void main() {
  late MockIAuthenticationRepository mockAuthenticationRepository;
  late AuthenticationUseCase authenticationUseCase;

  setUp(() {
    mockAuthenticationRepository = MockIAuthenticationRepository();
    authenticationUseCase = AuthenticationUseCase(mockAuthenticationRepository);
  });

  group('login', () {
    test('should call login on the repository with correct data', () async {
      // Arrange
      String email = 'test@example.com';
      String password = 'password123';
      when(mockAuthenticationRepository.login(email, password)).thenAnswer((_) async => (1, 'support'));

      // Act
      var result = await authenticationUseCase.login(email, password);

      // Assert
      verify(mockAuthenticationRepository.login(email, password)).called(1);
      expect(result, equals((1, 'support')));
    });
  });

  group('logOut', () {
    test('should call logOut on the repository', () async {
      // Arrange
      when(mockAuthenticationRepository.logOut()).thenAnswer((_) async => true);

      // Act
      var result = await authenticationUseCase.logOut();

      // Assert
      verify(mockAuthenticationRepository.logOut()).called(1);
      expect(result, isTrue);
    });
  });
}

