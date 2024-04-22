import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:loggy/loggy.dart";
import "package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/clients_menu.dart";

class CoordinatorMain extends StatelessWidget {
  final String email;
  const CoordinatorMain({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coordinator Page"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logInfo("Going to Clients List");
            Get.to(() => const ClientsMenu());
          },
          child: const Text("Clients List"),
        ),
      ),
    );
  }
}
