import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/client.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/client_usecase.dart';
import '../../mocks/client_test.mocks.mocks.dart';

void main() {
  late MockIClientRepository mockClientRepository;
  late ClientUseCase clientUseCase;

  setUp(() {
    mockClientRepository = MockIClientRepository();
    clientUseCase = ClientUseCase(mockClientRepository);
  });

  group('getClients', () {
    test('should call getClients on the repository', () async {
      // Arrange
      when(mockClientRepository.getClients()).thenAnswer((_) async => <Client>[]);

      // Act
      await clientUseCase.getClients();

      // Assert
      verify(mockClientRepository.getClients()).called(1);
    });
  });

  group('addClient', () {
    test('should call addClient on the repository with correct data', () async {
      // Arrange
      Client dummyClient = Client(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );
      when(mockClientRepository.addClient(dummyClient)).thenAnswer((_) async => true);

      // Act
      await clientUseCase.addClient(dummyClient);

      // Assert
      verify(mockClientRepository.addClient(dummyClient)).called(1);
    });
  });

  // Add similar tests for updateClient, deleteClient, and getClientById
}
