import '../models/support_user.dart';
import '../repositories/i_support_user_repository.dart';

class SupportUserUseCase {
  final ISupportUserRepository _repository;

  SupportUserUseCase(this._repository);

  Future<List<SupportUser>> getSupportUsers() async => await _repository.getSupportUsers();

  Future<bool> addSupportUser(SupportUser supportUser) async => await _repository.addSupportUser(supportUser);

  Future<bool> updateSupportUser(SupportUser supportUser) async =>
      await _repository.updateSupportUser(supportUser);

  Future<bool> deleteSupportUser(int id) async => await _repository.deleteSupportUser(id);

  Future<SupportUser> getSupportUserById(int id) async => await _repository.getSupportUserById(id);
}
