import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({Key? key}) : super(key: key);

  @override
  _CreateClientState createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CoordinatorController coordinatorController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New User'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
                            await coordinatorController.addClient(
                                controllerFirstName.text,
                                controllerLastName.text,
                                controllerEmail.text);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white), 
                          child: const Text("Save")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}