import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/coordinator_main.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/support/support_main.dart';
import '../../controller/authentication_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    logInfo('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword).then((value) {
        if (value.$2 == "coordinator") {
          Get.snackbar(
            "Login",
            "Login successful",
            icon: const Icon(Icons.person, color: Colors.green),
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.off(() => CoordinatorMain(email: theEmail));
        } else if(value.$2 == "support"){
          Get.snackbar(
            "Login",
            "Login successful",
            icon: const Icon(Icons.person, color: Colors.green),
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.off(() => SupportMain(id: value.$1));
        } 
      });
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                child: const Column(
                  children: [
                    Text("SupportTech",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        )),
                    Icon(
                      Icons.support_agent,
                      size: 50,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width < 800
                        ? MediaQuery.of(context).size.width * 0.05
                        : MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              const Text(
                                "Login with email",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: controllerEmail,
                                decoration: const InputDecoration(
                                    labelText: "Email address"),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Enter email";
                                  } else if (!value.contains('@')) {
                                    return "Enter valid email address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: controllerPassword,
                                decoration:
                                    const InputDecoration(labelText: "Password"),
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Enter password";
                                  } else if (value.length < 6) {
                                    return "Password should have at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                              FocusScope.of(context).requestFocus(FocusNode());
                              final form = _formKey.currentState;
                              form!.save();
                              if (_formKey.currentState!.validate()) {
                                await _login(controllerEmail.text,
                                    controllerPassword.text);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text("Submit"), ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
