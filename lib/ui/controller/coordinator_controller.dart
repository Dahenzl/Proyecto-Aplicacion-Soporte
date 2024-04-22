import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class CoordinatorController extends GetxController {
  final RxList<Client> _clients = <Client>[
    Client(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com'),
    Client(
        id: 2,
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane.doe@example.com'),
    Client(
        id: 3,
        firstName: 'Alice',
        lastName: 'Smith',
        email: 'alice.smith@example.com'),
  ].obs;

  final RxList<Support> _supports = <Support>[
    Support(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'jhon.doe@example.com',
        password: '123456'),
    Support(
        id: 2,
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane.doe@example.com',
        password: '123456')
  ].obs;

  final List<Report> _reports = <Report>[
    Report(
      id: 1,
      title: 'Reporte 1',
      description: 'Descripción del reporte 1',
      date: DateTime.now().subtract(Duration(days: 2)),
      minutes: 30,
      rating: 0,
      client: Client(
        id: 1,
        firstName: 'Juan',
        lastName: 'Pérez',
        email: 'juan.perez@example.com',
      ),
      support: Support(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'jhon.doe@example.com',
        password: '123456',
      ),
    ),
    Report(
      id: 2,
      title: 'Reporte 2',
      description: 'Descripción del reporte 2',
      date: DateTime.now().subtract(Duration(days: 1)),
      minutes: 45,
      rating: 0,
      client: Client(
        id: 2,
        firstName: 'María',
        lastName: 'González',
        email: 'maria.gonzalez@example.com',
      ),
      support: Support(
          id: 2,
          firstName: 'Jane',
          lastName: 'Doe',
          email: 'jane.doe@example.com',
          password: '123456'),
    ),
    Report(
        id: 3,
        title: 'Reporte 3',
        description: 'Descripción del reporte 3',
        date: DateTime.now(),
        minutes: 60,
        rating: 0,
        client: Client(
          id: 3,
          firstName: 'Carlos',
          lastName: 'López',
          email: 'carlos.lopez@example.com',
        ),
        support: Support(
            id: 1,
            firstName: 'John',
            lastName: 'Doe',
            email: 'jhon.doe@example.com',
            password: '123456')),
  ];

  List<Client> get clients => _clients;
  List<Support> get supports => _supports;
  List<Report> get reports => _reports;

  addClient(String firstName, String lastName, String email) {
    logInfo("Add client");
    int newId = _clients.isNotEmpty ? _clients.last.id + 1 : 1;
    _clients.add(Client(
        id: newId, firstName: firstName, lastName: lastName, email: email));
  }

  addSupport(String firstName, String lastName, String email, String password) {
    logInfo("Add support");
    int newId = _supports.isNotEmpty ? _supports.last.id + 1 : 1;
    _supports.add(Support(
        id: newId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password));
  }

  updateClient(Client client) {
    logInfo("Update client");
    int index = _clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _clients[index] = client;
    }
  }

  updateSupport(Support support) {
    logInfo("Update support");
    int index = _supports.indexWhere((s) => s.id == support.id);
    if (index != -1) {
      _supports[index] = support;
    }
  }

  deleteClient(int id) {
    logInfo("Delete client");
    _clients.removeWhere((client) => client.id == id);

    // Reorganizar los IDs después de eliminar un cliente
    reorganizeIdsClient();
  }

  deleteSupport(int id) {
    logInfo("Delete support");
    _supports.removeWhere((support) => support.id == id);

    // Reorganizar los IDs después de eliminar un soporte
    reorganizeIdsSupport();
  }

  reorganizeIdsClient() {
    for (int i = 0; i < _clients.length; i++) {
      _clients[i] = Client(
          id: i + 1,
          firstName: _clients[i].firstName,
          lastName: _clients[i].lastName,
          email: _clients[i].email);
    }
  }

  reorganizeIdsSupport() {
    for (int i = 0; i < _supports.length; i++) {
      _supports[i] = Support(
          id: i + 1,
          firstName: _supports[i].firstName,
          lastName: _supports[i].lastName,
          email: _supports[i].email,
          password: _supports[i].password);
    }
  }

  void rateReport(int id, double rating) {
    logInfo("Rate report");
    int index = _reports.indexWhere((report) => report.id == id);
    if (index != -1) {
      Report updatedReport = _reports[index];
      updatedReport.rating = rating; // Suponiendo que tienes un método copyWith en tu modelo Report
      _reports[index] = updatedReport;
    }
  }
}

class Client {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Client(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email});
}

class Support {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  Support(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}

class Report {
  final int id;
  final Client client;
  final Support support;
  final String title;
  final String description;
  final DateTime date;
  final int minutes;
  double rating;

  Report(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.minutes,
      required this.client,
      required this.support,
      required this.rating});
}
