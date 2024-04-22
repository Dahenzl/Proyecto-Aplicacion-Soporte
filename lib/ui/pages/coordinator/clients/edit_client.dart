import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';

class EditClient extends StatefulWidget {
  const EditClient({super.key});

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  Client client = Get.arguments[0];
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CoordinatorController coordinatorController = Get.find();
    controllerFirstName.text = client.firstName;
    controllerLastName.text = client.lastName;
    controllerEmail.text = client.email;
    return Scaffold(
      appBar: AppBar(
        title: Text("${client.firstName} ${client.lastName}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                await coordinatorController.deleteClient(client.id);
                Get.back();
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerFirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerLastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () async {
                            await coordinatorController.updateClient(Client(
                                id: client.id,
                                email: controllerEmail.text,
                                firstName: controllerFirstName.text,
                                lastName: controllerLastName.text));
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white),
                          child: const Text("Update")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}