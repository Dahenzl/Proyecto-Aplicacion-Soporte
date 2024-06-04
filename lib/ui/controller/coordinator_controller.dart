import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/client.dart';
import '../../domain/models/report.dart';
import '../../domain/models/support_user.dart';

import '../../domain/use_case/client_usecase.dart';
import '../../domain/use_case/report_usecase.dart';
import '../../domain/use_case/support_user_usecase.dart';

class CoordinatorController extends GetxController {
  final RxList<Client> clients = <Client>[].obs;
  final RxList<SupportUser> supports = <SupportUser>[].obs;
  final RxList<Report> reports = <Report>[].obs;
  final ClientUseCase clientUseCase = Get.find();
  final SupportUserUseCase supportUserUseCase = Get.find();
  final ReportUseCase reportUseCase = Get.find();

  @override
  void onInit() {
    getClients();
    getSupports();
    getReports();
    super.onInit();
  }

  getClients() async {
    logInfo("Getting clients");
    clients.value = await clientUseCase.getClients();
    return clients;
  }

  getSupports() async {
    logInfo("Getting supports");
    supports.value = await supportUserUseCase.getSupportUsers();
    return supports;
  }

  getReports() async {
    logInfo("Getting reports");
    reports.value = await reportUseCase.getReports();
    return reports;
  }

  addClient(String firstName, String lastName, String email) async {
    logInfo("Add client");
    int newId = clients.isNotEmpty ? clients.last.id + 1 : 1;
    await clientUseCase.addClient(Client(
        id: newId, firstName: firstName, lastName: lastName, email: email));
    getClients();
  }

  addSupport(String firstName, String lastName, String email, String password) async {
    logInfo("Add support");
    await supportUserUseCase.addSupportUser(SupportUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password));
    getSupports();
  }

  // No sirve aún
  updateClient(Client client) async {
    logInfo("Update client");
    int index = clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      await clientUseCase.updateClient(client);
    }
    getClients();
  }

  // No sirve aún
  updateSupport(SupportUser support) async {
    logInfo("Update support");
    int index = supports.indexWhere((s) => s.id == support.id);
    if (index != -1) {
      await supportUserUseCase.updateSupportUser(support);
    }
    getSupports();
  }

  deleteClient(int id) async {
    logInfo("Delete client");
    await clientUseCase.deleteClient(id);
    getClients();

    // Reorganizar los IDs después de eliminar un cliente
    reorganizeIdsClient();
  }

  deleteSupport(int id) async {
    logInfo("Delete support");
    await supportUserUseCase.deleteSupportUser(id);
    getSupports();

    // Reorganizar los IDs después de eliminar un soporte
    reorganizeIdsSupport();
  }

  reorganizeIdsClient() {
    for (int i = 0; i < clients.length; i++) {
      clients[i] = Client(
          id: i + 1,
          firstName: clients[i].firstName,
          lastName: clients[i].lastName,
          email: clients[i].email);
    }
  }

  reorganizeIdsSupport() {
    for (int i = 0; i < supports.length; i++) {
      supports[i] = SupportUser(
          id: i + 1,
          firstName: supports[i].firstName,
          lastName: supports[i].lastName,
          email: supports[i].email,
          password: supports[i].password);
    }
  }

  // void rateReport(int id, double rating) {
  //   logInfo("Rate report");
  //   int index = reports.indexWhere((report) => report.id == id);
  //   if (index != -1) {
  //     Report updatedReport = reports[index];
  //     updatedReport.rating =
  //         rating; // Suponiendo que tienes un método copyWith en tu modelo Report
  //     reports[index] = updatedReport;
  //   }
  // }

  Future<void> updateReport(Report report) async {
    logInfo("Update report");
    int index = reports.indexWhere((r) => r.id == report.id);
    if (index != -1) {
      await reportUseCase.updateReport(report);
      getReports();
    }
  }
}
