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
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: controllerFirstName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: controllerLastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  )),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              final form = _formKey.currentState;
                              form!.save();
                              if (_formKey.currentState!.validate()) {
                                await coordinatorController.addClient(
                                  controllerFirstName.text,
                                  controllerLastName.text,
                                  controllerEmail.text);
                                Get.back();
                              }
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
      ),
    );
  }
}
