import '../../../domain/models/report.dart';

abstract class IReportDataSource {
  Future<List<Report>> getReports();

  Future<List<Report>> getReportsBySupportId(int supportId);

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);
}
