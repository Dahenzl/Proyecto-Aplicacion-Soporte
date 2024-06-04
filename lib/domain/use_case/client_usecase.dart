import '../models/client.dart';
import '../repositories/i_client_repository.dart';

class ClientUseCase {
  final IClientRepository _repository;

  ClientUseCase(this._repository);

  Future<List<Client>> getClients() async => await _repository.getClients();

  Future<bool> addClient(Client client) async => await _repository.addClient(client);

  Future<bool> updateClient(Client client) async =>
      await _repository.updateClient(client);

  Future<bool> deleteClient(int id) async => await _repository.deleteClient(id);

  Future<Client> getClientById(int id) async => await _repository.getClientById(id);
}
