import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';

class EditSupport extends StatefulWidget {
  const EditSupport({super.key});

  @override
  State<EditSupport> createState() => _EditSupportState();
}

class _EditSupportState extends State<EditSupport> {
  Support support = Get.arguments[0];
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    CoordinatorController coordinatorController = Get.find();
    controllerFirstName.text = support.firstName;
    controllerLastName.text = support.lastName;
    controllerEmail.text = support.email;
    controllerPassword.text = support.password;
    return Scaffold(
      appBar: AppBar(
        title: Text("${support.firstName} ${support.lastName}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                await coordinatorController.deleteSupport(support.id);
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
              TextFormField(
                controller: controllerPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }
                  ),
                ),
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
                                await coordinatorController.updateSupport(Support(
                                    id: support.id,
                                    email: controllerEmail.text,
                                    firstName: controllerFirstName.text,
                                    lastName: controllerLastName.text,
                                    password: controllerPassword.text));
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
