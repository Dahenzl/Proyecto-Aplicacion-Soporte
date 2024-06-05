import 'package:proyecto_aplicacion_soporte/data/repositories/client_repository.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/client.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/client_test.mocks.mocks.dart';

void main() {
  late ClientRepository clientRepository;
  late MockIClientDataSource mockClientDataSource;

  setUp(() {
    mockClientDataSource = MockIClientDataSource();
    clientRepository = ClientRepository(mockClientDataSource);
  });

  group('ClientRepository Tests', () {
    test('getClients should retrieve clients from the data source', () async {
      // Arrange
      when(mockClientDataSource.getClients()).thenAnswer((_) async => <Client>[]);

      // Act
      var clients = await clientRepository.getClients();

      // Assert
      verify(mockClientDataSource.getClients()).called(1);
      expect(clients, isA<List<Client>>());
    });

    test('addClient should forward the addClient call to the data source', () async {
      // Arrange
      Client newClient = Client(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          email: 'johndoe@example.com');
      when(mockClientDataSource.addClient(any)).thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.addClient(newClient);

      // Assert
      verify(mockClientDataSource.addClient(newClient)).called(1);
      expect(result, isTrue);
    });

    test('updateClient should forward the updateClient call to the data source', () async {
      // Arrange
      Client updatedClient = Client(
          id: 1,
          firstName: 'John',
          lastName: 'Smith',
          email: 'johnsmith@example.com');
      when(mockClientDataSource.updateClient(any)).thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.updateClient(updatedClient);

      // Assert
      verify(mockClientDataSource.updateClient(updatedClient)).called(1);
      expect(result, isTrue);
    });

    test('deleteClient should forward the deleteClient call to the data source', () async {
      // Arrange
      int clientId = 1;
      when(mockClientDataSource.deleteClient(any)).thenAnswer((_) async => true);

      // Act
      bool result = await clientRepository.deleteClient(clientId);

      // Assert
      verify(mockClientDataSource.deleteClient(clientId)).called(1);
      expect(result, isTrue);
    });
  });
}
