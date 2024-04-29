import '../models/report.dart';
import '../repositories/i_report_repository.dart';

class ReportUseCase {
  final IReportRepository _repository;

  ReportUseCase(this._repository);

  Future<List<Report>> getReports() async => await _repository.getReports();

  Future<bool> addReport(Report report) async => await _repository.addReport(report);

  Future<bool> updateReport(Report report) async =>
      await _repository.updateReport(report);

  Future<bool> deleteReport(int id) async => await _repository.deleteReport(id);
}
