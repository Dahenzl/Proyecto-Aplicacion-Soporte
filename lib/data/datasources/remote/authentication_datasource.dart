import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_authentication_datasource.dart';
import '../../../domain/models/support_user.dart';
import 'package:http/http.dart' as http;

class AuthenticationDataSource implements IAuthenticationDataSource{
  final http.Client httpClient;

  AuthenticationDataSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<SupportUser>> getSupportUsers() async {
    logError("Web service: getting support users...");

    final response = await httpClient.get(
      Uri.parse("https://retoolapi.dev/tRq1YZ/support"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<SupportUser> supportUsers =
          data.skip(1).map((x) => SupportUser.fromJson(x)).toList();
      logInfo("Web service: support users retrieved successfully.");
      return supportUsers;
    } else {
      final String errorMessage =
          'Failed to get support users: ${response.statusCode}';
      logError(errorMessage);
      throw Exception(errorMessage);
    }
  }

  @override
  Future<(int, String)> login(String email, String password) async {
    if (email == 'a@a.com' && password == '123456') {
      return (1, 'coordinator');
    } else if(email == 'b@a.com' && password == '123456') {
      return (2, 'coordinator');
    }
    List<SupportUser> supportUsers = await getSupportUsers();
    for (SupportUser supportUser in supportUsers) {
      if (supportUser.email == email && supportUser.password == password) {
        return (supportUser.id, 'support');
      }
    }
    throw Exception('Credenciales inválidas');
  }

  @override
  Future<bool> logOut() async {
    return Future.value(false);
  }
}
