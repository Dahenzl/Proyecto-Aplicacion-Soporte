import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:loggy/loggy.dart";
import "package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/clients_menu.dart";
import "package:proyecto_aplicacion_soporte/ui/pages/coordinator/support/supports_menu.dart";

class CoordinatorMain extends StatelessWidget {
  final String email;
  const CoordinatorMain({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coordinator Page"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome Back Coordinator ${email[0].capitalize}!",
                style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            const Icon(Icons.supervised_user_circle,
                size: 200, color: Colors.blue),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                textStyle: const TextStyle(fontSize: 25),
              ),
              onPressed: () {
                logInfo("Going to Clients List");
                Get.to(() => const ClientsMenu());
              },
              child: const Text("Clients List"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                textStyle: const TextStyle(fontSize: 25),
              ),
              onPressed: () {
                logInfo("Going to Support List");
                Get.to(() => const SupportsMenu());
              },
              child: const Text("Support List"),
            ),
          ],
        ),
      ),
    );
  }
}
