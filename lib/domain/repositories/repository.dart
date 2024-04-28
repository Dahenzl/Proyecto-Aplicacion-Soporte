import '../../data/datasources/remote/client_datasource.dart';
import '../../data/datasources/remote/report_datasource.dart';
import '../../data/datasources/remote/support_user_datasource.dart';

import '../models/client.dart';
import '../models/report.dart';
import '../models/support_user.dart';

class Repository {
  late ClientDataSource _clientDataSource;
  late ReportDataSource _reportDataSource;
  late SupportUserDataSource _supportUserDataSource;

  Repository() {
    _clientDataSource = ClientDataSource();
    _reportDataSource = ReportDataSource();
    _supportUserDataSource = SupportUserDataSource();
  }

  Future<List<Client>> getClients() async => await _clientDataSource.getClients();

  Future<bool> addClient(Client client) async =>
      await _clientDataSource.addClient(client);

  Future<bool> updateClient(Client client) async =>
      await _clientDataSource.updateClient(client);

  Future<bool> deleteClient(Client client) async =>
      await _clientDataSource.deleteClient(client);

  Future<List<Report>> getReports() async => await _reportDataSource.getReports();

  Future<bool> addReport(Report report) async =>
      await _reportDataSource.addReport(report);

  Future<bool> updateReport(Report report) async =>
      await _reportDataSource.updateReport(report);

  Future<bool> deleteReport(Report report) async =>
      await _reportDataSource.deleteReport(report);

  Future<List<SupportUser>> getSupportUsers() async => await _supportUserDataSource.getSupportUsers();

  Future<bool> addSupportUser(SupportUser supportUser) async =>
      await _supportUserDataSource.addSupportUser(supportUser);

  Future<bool> updateSupportUser(SupportUser supportUser) async =>
      await _supportUserDataSource.updateSupportUser(supportUser);

  Future<bool> deleteSupportUser(SupportUser supportUser) async =>
      await _supportUserDataSource.deleteSupportUser(supportUser);

}