import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/coordinator_main.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/support/support_main.dart';

class AuthenticationController extends GetxController {
  final logged = false.obs;
  final errorMessage = ''.obs; // Mensaje de error observable

  bool get isLogged => logged.value;

  Future<void> login(String email, String password) async {
    try {
      // Aquí deberías agregar la lógica real de inicio de sesión, como llamar a una API para autenticar al usuario.
      // Este es un ejemplo de simulación de inicio de sesión exitoso basado en las credenciales del usuario.
      if (email == 'a@a.com' || email == 'b@a.com' && password == '123456') {
        logged.value = true;
        errorMessage.value = '';
        Get.to(
            () => CoordinatorMain(email: email)); // Limpiar mensaje de error
      } else if (email == 'c@c.com' && password == '123456') {
        logged.value = true;
        errorMessage.value = ''; // Limpiar mensaje de error
        Get.to(
            () => SupportMain(email: email));
      } else {
        throw Exception('Credenciales inválidas');
      }
    } catch (e) {
      logError('Error en el inicio de sesión: $e');
      errorMessage.value =
          'Error al iniciar sesión'; // Establecer mensaje de error
      throw e;
    }
  }

  Future<void> logOut() async {
    logged.value = false;
  }
}
