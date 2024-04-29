import '../../data/datasources/remote/i_report_datasource.dart';
import '../models/report.dart';

abstract class IReportRepository {
  final IReportDataSource _reportDatatasource;

  IReportRepository(this._reportDatatasource);

  Future<List<Report>> getReports();

  Future<bool> addReport(Report report);

  Future<bool> updateReport(Report report);

  Future<bool> deleteReport(int id);
}