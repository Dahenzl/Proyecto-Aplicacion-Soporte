import '../../../domain/models/support_user.dart';

abstract class ISupportUserDataSource {
  Future<List<SupportUser>> getSupportUsers();

  Future<SupportUser> getSupportUserById(int id);

  Future<bool> isEmailInUse(String email);

  Future<bool> addSupportUser(SupportUser supportUser);

  Future<bool> updateSupportUser(SupportUser supportUser);

  Future<bool> deleteSupportUser(int id);
}
