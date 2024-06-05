import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/report.dart';
import 'package:http/http.dart' as http;

import 'i_report_datasource.dart';

class ReportDataSource implements IReportDataSource {
  final http.Client httpClient;
  final String apiKey = 'Z05bVs';

  ReportDataSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<Report>> getReports() async {
    logInfo("Web service: getting reports...");

    List<Report> reports = [];

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/$apiKey/reports"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      reports = List<Report>.from(data.skip(1).map((x) => Report.fromJson(x)));

      logInfo("Web service: Reports retrieved successfully.");
    } else {
      logError('Failed to get reports: ${response.statusCode}');
      throw Exception('Error code ${response.statusCode}');
    }

    return Future.value(reports);
  }

  @override
  Future<List<Report>> getReportsBySupportId(int supportId) async {
    logInfo("Web service: getting reports by support id...");

    final currentReports = await getReports();

    List<Report> filteredReports = currentReports.where((report) => report.supportId == supportId).toList();

    return Future.value(filteredReports);
  }

  @override
  Future<bool> addReport(Report report) async {
    logInfo("Web service: Adding report...");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/reports"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode == 201) {
      logInfo("Web service: Report added successfully.");
      return Future.value(true);
    } else {
      logError("Failed to add report: ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateReport(Report report) async {
    logInfo("Web service: Updating report...");

    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/${report.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode == 200) {
      logInfo("Web service: report updated successfully.");
      return Future.value(true);
    } else {
      logError("Failed to update report: ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteReport(int id) async {
    logInfo("Web service: Deleting report...");

    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      logInfo("Web service: report deleted successfully.");
      return Future.value(true);
    } else {
      logError("Failed to delete report: ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<List<Report>> getReportsBySupportId(int supportId) async {
    logInfo("Web service: getting reports by support id...");

    final currentReports = await getReports();

    List<Report> filteredReports = currentReports.where((report) => report.supportId == supportId).toList();

    return Future.value(filteredReports);
  }
}
