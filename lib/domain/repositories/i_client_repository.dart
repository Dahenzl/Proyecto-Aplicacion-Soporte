import '../../data/datasources/remote/i_client_datasource.dart';
import '../models/client.dart';

abstract class IClientRepository {
  final IClientDataSource _clientDatatasource;

  IClientRepository(this._clientDatatasource);

  Future<List<Client>> getClients();

  Future<bool> addClient(Client client);

  Future<bool> updateClient(Client client);

  Future<bool> deleteClient(int id);

  Future<Client> getClientById(int id);
}
