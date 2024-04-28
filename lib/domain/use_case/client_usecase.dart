import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/client.dart';
import '../repositories/repository.dart';

class ClientUseCase {
  final Repository _repository = Get.find();

  ClientUseCase();

  Future<List<Client>> getClients() async {
    logInfo("Getting clients from UseCase");
    return await _repository.getClients();
  }

  Future<void> addClient(Client client) async => await _repository.addClient(client);

  Future<void> updateClient(Client client) async =>
      await _repository.updateClient(client);

  deleteClient(Client client) async => await _repository.deleteClient(client);

}