import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/authentication_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/create_client.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/edit_client.dart';

class ClientsMenu extends StatefulWidget {
  const ClientsMenu({super.key});

  @override
  State<ClientsMenu> createState() => _ClientsMenuState();
}

class _ClientsMenuState extends State<ClientsMenu> {
  CoordinatorController coordinatorController = Get.find();
  AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients List"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(child: _getXlistView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("Add user from UI");
          Get.to(() => const CreateClient());
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getXlistView() {
    return Obx(
      () => ListView.builder(
        itemCount: coordinatorController.clients.length,
        itemBuilder: (context, index) {
          Client user = coordinatorController.clients[index];
          return Card(
            key: UniqueKey(),
            child: ListTile(
              title: Text("${user.firstName} ${user.lastName}"),
              subtitle: Text(user.email),
              onTap: () {
                Get.to(() => const EditClient(),
                    arguments: [user, user.id]);
              },
            ),
          );
        },
      ),
    );
  }
}
