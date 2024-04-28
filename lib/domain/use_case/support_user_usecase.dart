import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/support_user.dart';
import '../repositories/repository.dart';

class SupportUserUseCase {
  final Repository _repository = Get.find();

  SupportUserUseCase();

  Future<List<SupportUser>> getSupportUsers() async {
    logInfo("Getting support user from UseCase");
    return await _repository.getSupportUsers();
  }

  Future<void> addSupportUser(SupportUser support) async => await _repository.addSupportUser(support);

  Future<void> updateSupportUser(SupportUser support) async =>
      await _repository.updateSupportUser(support);

  deleteSupportUser(SupportUser support) async => await _repository.deleteSupportUser(support);

}