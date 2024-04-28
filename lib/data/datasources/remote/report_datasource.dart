import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/report.dart';
import 'package:http/http.dart' as http;

class ReportDataSource {

  Future<List<Report>> getReports() async {
    logError("Web service: getting reports...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/reports").replace(queryParameters: {"format": 'json'});
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Report> reports = data.map((x) => Report.fromJson(x)).toList();
      logInfo("Web service: Reports retrieved successfully.");
      return reports;
    } else {
      final String errorMessage = 'Failed to get reports: ${response.statusCode}';
      logError(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<bool> addReport(Report report) async {
    logInfo("Web service: Adding report...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/reports");
    final response = await http.post(
      requestUri,
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

  Future<bool> updateReport(Report report) async {
    logInfo("Web service: Updating report...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/reports/${report.id}");
    final response = await http.put(
      requestUri,
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

  Future<bool> deleteReport(Report report) async {
    logInfo("Web service: Deleting report...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/reports/${report.id}");
    final response = await http.delete(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      logInfo("Web service: report deleted successfully.");
      return true;
    } else {
      logError("Failed to delete report: ${response.statusCode}");
      return false;
    }
  }

}
