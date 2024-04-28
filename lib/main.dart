import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/authentication_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/support_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/authentication/login_page.dart';

import './domain/use_case/client_usecase.dart';
import './domain/repositories/repository.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(Repository());
  Get.put(ClientUseCase());

  Get.put(AuthenticationController());
  Get.put(CoordinatorController());
  Get.put(SupportController());
  Get.put(CoordinatorController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}