import '../../domain/models/report.dart';
import '../../domain/repositories/i_report_repository.dart';
import '../datasources/remote/i_report_datasource.dart';

class ReportRepository implements IReportRepository {
  final IReportDataSource _reportDatatasource;
  ReportRepository(this._reportDatatasource);

  @override
  Future<List<Report>> getReports() async =>
      await _reportDatatasource.getReports();

  @override
  Future<bool> addReport(Report report) async =>
      await _reportDatatasource.addReport(report);
  @override
  Future<bool> updateReport(Report report) async =>
      await _reportDatatasource.updateReport(report);
  @override
  Future<bool> deleteReport(int id) async =>
      await _reportDatatasource.deleteReport(id);
}
