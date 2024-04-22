import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class CoordinatorController extends GetxController {
  final RxList<Client> _clients = <Client>[
    Client(id: 1, firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com'),
    Client(id: 2, firstName: 'Jane', lastName: 'Doe', email: 'jane.doe@example.com'),
    Client(id: 3, firstName: 'Alice', lastName: 'Smith', email: 'alice.smith@example.com'),
  ].obs;

  List<Client> get clients => _clients;

  @override
  void onInit() {
    getClients();
    super.onInit();
  }

  getClients() {
    logInfo("Getting clients");
    _clients.value = [
      Client(id: 1, firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com'),
      Client(id: 2, firstName: 'Jane', lastName: 'Doe', email: 'jane.doe@example.com'),
      Client(id: 3, firstName: 'Alice', lastName: 'Smith', email: 'alice.smith@example.com'),
    ];
  }

  addClient(String firstName, String lastName, String email) {
    logInfo("Add client");
    int newId = _clients.isNotEmpty ? _clients.last.id + 1 : 1;
    _clients.add(Client(id: newId, firstName: firstName, lastName: lastName, email: email));
  }

  updateClient(Client client) {
    logInfo("Update client");
    int index = _clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _clients[index] = client;
    }
  }

  deleteClient(int id) {
    logInfo("Delete client");
    _clients.removeWhere((client) => client.id == id);

    // Reorganizar los IDs después de eliminar un cliente
    reorganizeIds();
  }

  reorganizeIds() {
    for (int i = 0; i < _clients.length; i++) {
      _clients[i] = Client(id: i + 1, firstName: _clients[i].firstName, lastName: _clients[i].lastName, email: _clients[i].email);
    }
  }
}

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Client({required this.id, required this.firstName, required this.lastName, required this.email});
}
