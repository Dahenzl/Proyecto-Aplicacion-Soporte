import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/support_user_usecase.dart';
import '../../mocks/support_user_test.mock.mocks.dart';

void main() {
  late MockISupportUserRepository mockSupportUserRepository;
  late SupportUserUseCase supportUserUseCase;

  setUp(() {
    mockSupportUserRepository = MockISupportUserRepository();
    supportUserUseCase = SupportUserUseCase(mockSupportUserRepository);
  });

  group('getSupportUsers', () {
    test('should return a list of support users from the repository', () async {
      // Arrange
      final expectedSupportUsers = <SupportUser>[
        SupportUser(id: 1, firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com', password: "hola123"),
        SupportUser(id: 2, firstName: 'Jane', lastName: 'Smith', email: 'jane.smith@example.com', password: "hola123"),
      ];
      when(mockSupportUserRepository.getSupportUsers()).thenAnswer((_) async => expectedSupportUsers);

      // Act
      final supportUsers = await supportUserUseCase.getSupportUsers();

      // Assert
      expect(supportUsers, equals(expectedSupportUsers));
      verify(mockSupportUserRepository.getSupportUsers()).called(1);
    });
  });

  group('addSupportUser', () {
    test('should add a support user to the repository', () async {
      // Arrange
      final supportUserToAdd = SupportUser(id: 1, firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com', password: "hola123");
      when(mockSupportUserRepository.addSupportUser(supportUserToAdd)).thenAnswer((_) async => true);

      // Act
      final result = await supportUserUseCase.addSupportUser(supportUserToAdd);

      // Assert
      expect(result, isTrue);
      verify(mockSupportUserRepository.addSupportUser(supportUserToAdd)).called(1);
    });
  });
}
