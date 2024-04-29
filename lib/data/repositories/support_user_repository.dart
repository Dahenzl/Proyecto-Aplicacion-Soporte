import '../../data/datasources/remote/support_user_datasource.dart';
import '../../domain/models/support_user.dart';
import '../../domain/repositories/i_support_user_repository.dart';
import '../datasources/remote/i_support_user_datasource.dart';

class SupportUserRepository implements ISupportUserRepository {
  final ISupportUserDataSource _supportUserDatatasource;
  SupportUserRepository(this._supportUserDatatasource);

  @override
  Future<List<SupportUser>> getSupportUsers() async => await _supportUserDatatasource.getSupportUsers();

  @override
  Future<bool> addSupportUser(SupportUser supportUser) async =>
      await _supportUserDatatasource.addSupportUser(supportUser);
  @override
  Future<bool> updateSupportUser(SupportUser supportUser) async =>
      await _supportUserDatatasource.updateSupportUser(supportUser);
  @override
  Future<bool> deleteSupportUser(int id) async =>
      await _supportUserDatatasource.deleteSupportUser(id);
}
