import 'package:proyecto_aplicacion_soporte/data/repositories/support_user_repository.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/support_user_test.mock.mocks.dart';

void main() {
  late SupportUserRepository supportUserRepository;
  late MockISupportUserDataSource mockSupportUserDataSource;

  setUp(() {
    mockSupportUserDataSource = MockISupportUserDataSource();
    supportUserRepository = SupportUserRepository(mockSupportUserDataSource);
  });

  group('SupportUserRepository Tests', () {
    test('getSupportUsers should retrieve support users from the data source', () async {
      // Arrange
      when(mockSupportUserDataSource.getSupportUsers()).thenAnswer((_) async => <SupportUser>[]);

      // Act
      var supportUsers = await supportUserRepository.getSupportUsers();

      // Assert
      verify(mockSupportUserDataSource.getSupportUsers()).called(1);
      expect(supportUsers, isA<List<SupportUser>>());
    });

    test('addSupportUser should forward the addSupportUser call to the data source', () async {
      // Arrange
      SupportUser newSupportUser = SupportUser(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'johndoe@example.com',
        password: 'password123',
      );
      when(mockSupportUserDataSource.addSupportUser(any)).thenAnswer((_) async => true);

      // Act
      bool result = await supportUserRepository.addSupportUser(newSupportUser);

      // Assert
      verify(mockSupportUserDataSource.addSupportUser(newSupportUser)).called(1);
      expect(result, isTrue);
    });

    test('updateSupportUser should forward the updateSupportUser call to the data source', () async {
      // Arrange
      SupportUser updatedSupportUser = SupportUser(
        id: 1,
        firstName: 'John',
        lastName: 'Smith',
        email: 'johnsmith@example.com',
        password: 'newpassword',
      );
      when(mockSupportUserDataSource.updateSupportUser(any)).thenAnswer((_) async => true);

      // Act
      bool result = await supportUserRepository.updateSupportUser(updatedSupportUser);

      // Assert
      verify(mockSupportUserDataSource.updateSupportUser(updatedSupportUser)).called(1);
      expect(result, isTrue);
    });

    test('deleteSupportUser should forward the deleteSupportUser call to the data source', () async {
      // Arrange
      int supportUserId = 1;
      when(mockSupportUserDataSource.deleteSupportUser(any)).thenAnswer((_) async => true);

      // Act
      bool result = await supportUserRepository.deleteSupportUser(supportUserId);

      // Assert
      verify(mockSupportUserDataSource.deleteSupportUser(supportUserId)).called(1);
      expect(result, isTrue);
    });

    test('getSupportUserById should retrieve a support user by id from the data source', () async {
      // Arrange
      int userId = 1;
      SupportUser expectedUser = SupportUser(
        id: userId,
        firstName: 'John',
        lastName: 'Doe',
        email: 'johndoe@example.com',
        password: 'password123',
      );
      when(mockSupportUserDataSource.getSupportUserById(userId)).thenAnswer((_) async => expectedUser);

      // Act
      var supportUser = await supportUserRepository.getSupportUserById(userId);

      // Assert
      verify(mockSupportUserDataSource.getSupportUserById(userId)).called(1);
      expect(supportUser, isA<SupportUser>());
      expect(supportUser.id, equals(expectedUser.id));
      expect(supportUser.firstName, equals(expectedUser.firstName));
      expect(supportUser.lastName, equals(expectedUser.lastName));
      expect(supportUser.email, equals(expectedUser.email));
      expect(supportUser.password, equals(expectedUser.password));
    });

  });
}
