import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/create_client.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/clients/edit_client.dart';

import '../../../../domain/models/client.dart';

class ClientsMenu extends StatefulWidget {
  const ClientsMenu({super.key});

  @override
  State<ClientsMenu> createState() => _ClientsMenuState();
}

class _ClientsMenuState extends State<ClientsMenu> {
  bool isLoading = true;
  CoordinatorController coordinatorController = Get.find();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await coordinatorController.getClients();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    coordinatorController.getClients();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients List"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : Center(child: _getXlistView()),
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
          Client client = coordinatorController.clients[index];
          return Card(
            key: UniqueKey(),
            child: ListTile(
              title: Text("${client.firstName} ${client.lastName}"),
              subtitle: Text(client.email),
              onTap: () {
                Get.to(() => const EditClient(),
                    arguments: [client, client.id]);
              },
            ),
          );
        },
      ),
    );
  }
}
