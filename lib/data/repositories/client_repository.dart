import '../../domain/models/client.dart';
import '../../domain/repositories/i_client_repository.dart';
import '../datasources/remote/i_client_datasource.dart';

class ClientRepository implements IClientRepository {
  final IClientDataSource _clientDatatasource;
  ClientRepository(this._clientDatatasource);

  @override
  Future<List<Client>> getClients() async => await _clientDatatasource.getClients();

  @override
  Future<bool> addClient(Client client) async =>
      await _clientDatatasource.addClient(client);
  @override
  Future<bool> updateClient(Client client) async =>
      await _clientDatatasource.updateClient(client);
  @override
  Future<bool> deleteClient(int id) async =>
      await _clientDatatasource.deleteClient(id);
}
