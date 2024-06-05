import '../../data/datasources/remote/i_support_user_datasource.dart';
import '../models/support_user.dart';

abstract class ISupportUserRepository {
  final ISupportUserRepository _supportUserDatatasource;

  ISupportUserRepository(this._supportUserDatatasource);

  Future<List<SupportUser>> getSupportUsers();

  Future<bool> addSupportUser(SupportUser supportUser);

  Future<bool> updateSupportUser(SupportUser supportUser);

  Future<bool> deleteSupportUser(int id);

  Future<SupportUser> getSupportUserById(int id);
}