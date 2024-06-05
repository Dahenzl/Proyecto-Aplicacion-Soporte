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

  getClients() async {
    logInfo("Getting clients");
    clients.value = await clientUseCase.getClients();
    return clients;
  }

  getClientById(int id) async {
    logInfo("Getting client by id");
    return await clientUseCase.getClientById(id);
  }

  getSupports() async {
    logInfo("Getting supports");
    supports.value = await supportUserUseCase.getSupportUsers();
    return supports;
  }

  getSupportById(int id) async {
    logInfo("Getting support by id");
    return await supportUserUseCase.getSupportUserById(id);
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
    await getClients();
  }

  addSupport(String firstName, String lastName, String email, String password) async {
    logInfo("Add support");
    await supportUserUseCase.addSupportUser(SupportUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password));
    await getSupports();
  }

  updateClient(Client client) async {
    logInfo("Update client");
    await clientUseCase.updateClient(client);
    await getClients();
  }

  updateSupport(SupportUser support) async {
    logInfo("Update support");
    await supportUserUseCase.updateSupportUser(support);
    await getSupports();
  }

  deleteClient(int id) async {
    logInfo("Delete client");
    await clientUseCase.deleteClient(id);
    await getClients();
  }

  deleteSupport(int id) async {
    logInfo("Delete support");
    await supportUserUseCase.deleteSupportUser(id);
    await getSupports();
  }

  Future<void> updateReport(Report report) async {
    logInfo("Update report");
    int index = reports.indexWhere((r) => r.id == report.id);
    if (index != -1) {
      await reportUseCase.updateReport(report);
      await getReports();
    }
  }
}
