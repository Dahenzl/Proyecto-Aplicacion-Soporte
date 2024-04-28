import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';

import '../../../../domain/models/client.dart';

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
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: controllerFirstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: controllerLastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                              if (_formKey.currentState!.validate()) {
                                await coordinatorController.updateClient(Client(
                                    id: client.id,
                                    email: controllerEmail.text,
                                    firstName: controllerFirstName.text,
                                    lastName: controllerLastName.text));
                                Get.back();
                              }
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
      ),
    );
  }
}
