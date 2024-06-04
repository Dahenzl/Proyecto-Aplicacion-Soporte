import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:loggy/loggy.dart";
import "package:proyecto_aplicacion_soporte/ui/controller/authentication_controller.dart";
import "package:proyecto_aplicacion_soporte/ui/pages/authentication/login_page.dart";
import 'reports/report_work.dart';

class SupportMain extends StatefulWidget {
  final String email;

  const SupportMain({Key? key, required this.email}) : super(key: key);

  @override
  State<SupportMain> createState() => _SupportMainState();
}

class _SupportMainState extends State<SupportMain> {
  AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Page"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logInfo("Logout");
              authenticationController.logout();
              Get.off(() => const LoginPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome Back Support ${widget.email[0].capitalize}!",
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
                logInfo("Going to Reports");
                Get.to(() => const SendReports());
              },
              child: const Text("Report Work"),
            ),
          ],
        ),
      ),
    );
  }
}
