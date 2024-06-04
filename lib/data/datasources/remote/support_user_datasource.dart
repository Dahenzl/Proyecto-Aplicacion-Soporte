import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/support_user.dart';
import 'package:http/http.dart' as http;

import 'i_support_user_datasource.dart';

class SupportUserDataSource implements ISupportUserDataSource {
  final http.Client httpClient;
  final String apiKey = 'tRq1YZ';

  SupportUserDataSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<SupportUser>> getSupportUsers() async {
    logInfo("Web service: getting support users...");

    List<SupportUser> supportUsers = [];

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/$apiKey/support"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      supportUsers = List<SupportUser>.from(
          data.skip(1).map((x) => SupportUser.fromJson(x)));

      logInfo("Web service: support users retrieved successfully.");
    } else {
      logError('Failed to get support users: ${response.statusCode}');
      throw Exception('Error code ${response.statusCode}');
    }

    return Future.value(supportUsers);
  }

  @override
  Future<SupportUser> getSupportUserById(int id) async {
    logInfo("Web service: getting support user by id...");

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/$apiKey/support/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final supportUser = SupportUser.fromJson(data);
      logInfo("Web service: Support user retrieved successfully.");
      return Future.value(supportUser);
    } else {
      logError('Failed to get support user: ${response.statusCode}');
      throw Exception('Error code ${response.statusCode}');
    }

  }

  @override
  Future<bool> isEmailInUse(String email) async {
    logInfo("Web service: checking if the email is already in use...");

    final currentSupportUsers = await getSupportUsers();

    bool emailInUse = currentSupportUsers.any((user) => user.email == email);

    return Future.value(emailInUse);
  }

  @override
  Future<bool> addSupportUser(SupportUser supportUser) async {
    logInfo("Web service: Adding support user...");

    final emailExists = await isEmailInUse(supportUser.email);

    if (emailExists) {
      logInfo("Web service: Email already in use.");
      return Future.value(false);
    }

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/support"),
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

  @override
  Future<bool> updateSupportUser(SupportUser supportUser) async {
    logInfo("Web service: Updating support user...");

    //final emailExists = await isEmailInUse(supportUser.email);

    //if (emailExists) {
      //logInfo("Web service: Email already in use.");
      //return Future.value(false);
    //}

    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/support/${supportUser.id}"),
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

  @override
  Future<bool> deleteSupportUser(int id) async {
    logInfo("Web service: Deleting support user...");

    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/users/$id"),
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
