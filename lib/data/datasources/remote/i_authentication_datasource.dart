import '../../../domain/models/support_user.dart';

abstract class IAuthenticationDataSource {
  Future<List<SupportUser>> getSupportUsers();

  Future<(int, String)> login(String email, String password);

  Future<bool> logOut();
}
