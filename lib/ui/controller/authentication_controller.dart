import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/authentication_usecase.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/coordinator_main.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/support/support_main.dart';

class AuthenticationController extends GetxController {
  final logged = false.obs;
  final id = 0.obs;
  final type = ''.obs;
  final errorMessage = ''.obs; // Mensaje de error observable
  final AuthenticationUseCase authenticationUseCase = Get.find();

  login(String email, String password) async {
    logInfo("Trying to login...");
    authenticationUseCase.login(email, password).then((value) => {
          if (value.$2 == 'coordinator')
            {
              logged.value = true,
              id.value = value.$1,
              type.value = "coordinator",
              Get.off(() => CoordinatorMain(id: value.$1))
            }
          else if (value.item1 == 201)
            {
              logged.value = true,
              id.value = value.item2,
              type.value = "support",
              Get.off(() => SupportMain())
            }
          else
            {
              errorMessage.value = "Usuario o contraseña incorrectos"
            }
        
    });
  }

  logout() async {
    logInfo("Logout");
    await authenticationUseCase.logOut();
  }
}
