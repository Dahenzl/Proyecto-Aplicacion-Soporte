import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/report.dart';
import '../repositories/repository.dart';

class ReportUseCase {
  final Repository _repository = Get.find();

  ReportUseCase();

  Future<List<Report>> getReports() async {
    logInfo("Getting reports from UseCase");
    return await _repository.getReports();
  }

  Future<void> addReport(Report report) async => await _repository.addReport(report);

  Future<void> updateReport(Report report) async =>
      await _repository.updateReport(report);

  deleteReport(Report report) async => await _repository.deleteReport(report);

}