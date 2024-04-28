import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/support_user.dart';
import 'package:http/http.dart' as http;

class SupportUserDataSource {

  Future<List<SupportUser>> getSupportUsers() async {
    logError("Web service: getting support users...");

    final requestUri = Uri.parse("https://retoolapi.dev/tRq1YZ/support").replace(queryParameters: {"format": 'json'});
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<SupportUser> supportUsers = data.map((x) => SupportUser.fromJson(x)).toList();
      logInfo("Web service: support users retrieved successfully.");
      return supportUsers;
    } else {
      final String errorMessage = 'Failed to get support users: ${response.statusCode}';
      logError(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<bool> addSupportUser(SupportUser supportUser) async {
    logInfo("Web service: Adding support user...");

    final requestUri = Uri.parse("https://retoolapi.dev/tRq1YZ/support");
    final response = await http.post(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(supportUser.toJson()),
    );

    if (response.statusCode == 201) {
      logInfo("Web service: Support user added successfully.");
      return Future.value(true);
    } else {
      logError("Failed to add support user: ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateSupportUser(SupportUser supportUser) async {
    logInfo("Web service: Updating support user...");

    final requestUri = Uri.parse("https://retoolapi.dev/tRq1YZ/support/${supportUser.id}");
    final response = await http.put(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(supportUser.toJson()),
    );

    if (response.statusCode == 200) {
      logInfo("Web service: Support user updated successfully.");
      return Future.value(true);
    } else {
      logError("Failed to update support user: ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteSupportUser(SupportUser supportUser) async {
    logInfo("Web service: Deleting support user...");

    final requestUri = Uri.parse("https://retoolapi.dev/tRq1YZ/support/${supportUser.id}");
    final response = await http.delete(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      logInfo("Web service: Support user deleted successfully.");
      return Future.value(true);
    } else {
      logError("Failed to delete support user: ${response.statusCode}");
      return Future.value(false);
    }
  }

}

