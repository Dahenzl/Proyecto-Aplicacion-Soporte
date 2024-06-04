import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/authentication_usecase.dart';

class AuthenticationController extends GetxController {
  final logged = false.obs;
  final errorMessage = ''.obs; // Mensaje de error observable
  final AuthenticationUseCase authenticationUseCase = Get.find();

  login(String email, String password) async {
    logInfo("Trying to login...");
    return await authenticationUseCase.login(email, password);
  }

  logout() async {
    logInfo("Logout");
    logged.value = await authenticationUseCase.logOut();
  }
}
