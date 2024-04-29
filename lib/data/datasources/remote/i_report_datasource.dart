import '../../../domain/models/report.dart';

abstract class IReportDataSource {
  Future<List<Report>> getReports();

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);
}
