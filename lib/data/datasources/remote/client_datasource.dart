import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/client.dart';
import 'package:http/http.dart' as http;

class ClientDataSource {

  Future<List<Client>> getClients() async {
    logError("Web service: getting clients...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/clients").replace(queryParameters: {"format": 'json'});
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Client> clients = data.map((x) => Client.fromJson(x)).toList();
      logInfo("Web service: Clients retrieved successfully.");
      return clients;
    } else {
      final String errorMessage = 'Failed to get clients: ${response.statusCode}';
      logError(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<bool> addClient(Client client) async {
    logInfo("Web service: Adding client...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/clients");
    final response = await http.post(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 201) {
      logInfo("Web service: Client added successfully.");
      return Future.value(true);
    } else {
      logError("Failed to add client: ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateClient(Client client) async {
    logInfo("Web service: Updating client...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/clients/${client.id}");
    final response = await http.put(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );

    if (response.statusCode == 200) {
      logInfo("Web service: Client updated successfully.");
      return Future.value(true);
    } else {
      logError("Failed to update client: ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteClient(Client client) async {
    logInfo("Web service: Deleting client...");

    final requestUri = Uri.parse("https://retoolapi.dev/f0yCMk/clients/${client.id}");
    final response = await http.delete(
      requestUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      logInfo("Web service: Client deleted successfully.");
      return true;
    } else {
      logError("Failed to delete client: ${response.statusCode}");
      return false;
    }
  }

}
