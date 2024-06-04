import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/client.dart';
import 'package:http/http.dart' as http;

import 'i_client_datasource.dart';

class ClientDataSource implements IClientDataSource {
  final http.Client httpClient;
  final String apiKey = 'f0yCMk';

  ClientDataSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<Client>> getClients() async {
    logInfo("Web service: getting clients...");

    List<Client> clients = [];

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/$apiKey/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      clients = List<Client>.from(data.skip(1).map((x) => Client.fromJson(x)));

      logInfo("Web service: Clients retrieved successfully.");
    } else {
      logError('Failed to get clients: ${response.statusCode}');
      throw Exception('Error code ${response.statusCode}');
    }

    return Future.value(clients);
  }

  @override
  Future<Client> getClientById(int id) async {
    logInfo("Web service: getting client by id...");

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/$apiKey/users/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final client = Client.fromJson(data);
      logInfo("Web service: client retrieved successfully.");
      return Future.value(client);
    } else {
      logError('Failed to get client: ${response.statusCode}');
      throw Exception('Error code ${response.statusCode}');
    }

  }

  @override
  Future<bool> addClient(Client client) async {
    logInfo("Web service: Adding client...");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/users"),
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

  @override
  Future<bool> updateClient(Client client) async {
    logInfo("Web service: Updating client...");

    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/users/${client.id}"),
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

  @override
  Future<bool> deleteClient(int id) async {
    logInfo("Web service: Deleting client...");

    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/users/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      logInfo("Web service: Client deleted successfully.");
      return Future.value(true);
    } else {
      logError("Failed to delete client: ${response.statusCode}");
      return Future.value(false);
    }
  }
}
