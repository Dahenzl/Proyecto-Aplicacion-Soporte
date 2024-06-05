import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/authentication_datasource.dart';
import 'package:proyecto_aplicacion_soporte/data/datasources/remote/i_authentication_datasource.dart';
import 'package:proyecto_aplicacion_soporte/data/repositories/authentication_repository.dart';
import 'package:proyecto_aplicacion_soporte/domain/repositories/i_authentication_repository.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/authentication_usecase.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/authentication_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/support_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/authentication/login_page.dart';

import 'data/datasources/remote/client_datasource.dart';
import 'data/datasources/remote/i_client_datasource.dart';
import 'data/datasources/remote/i_report_datasource.dart';
import 'data/datasources/remote/i_support_user_datasource.dart';
import 'data/repositories/client_repository.dart';
import 'domain/repositories/i_client_repository.dart';
import 'domain/repositories/i_report_repository.dart';
import 'domain/repositories/i_support_user_repository.dart';
import 'domain/use_case/client_usecase.dart';

import 'data/datasources/remote/report_datasource.dart';
import 'data/repositories/report_repository.dart';
import 'domain/use_case/report_usecase.dart';

import 'data/datasources/remote/support_user_datasource.dart';
import 'data/repositories/support_user_repository.dart';
import 'domain/use_case/support_user_usecase.dart';
import 'ui/pages/support/reports/report_work.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put<IClientDataSource>(ClientDataSource());
  Get.put<IClientRepository>(ClientRepository(Get.find()));
  Get.put(ClientUseCase(Get.find()));

  Get.put<IReportDataSource>(ReportDataSource());
  Get.put<IReportRepository>(ReportRepository(Get.find()));
  Get.put(ReportUseCase(Get.find()));

  Get.put<ISupportUserDataSource>(SupportUserDataSource());
  Get.put<ISupportUserRepository>(SupportUserRepository(Get.find()));
  Get.put(SupportUserUseCase(Get.find()));

  Get.put<IAuthenticationDataSource>(AuthenticationDataSource());
  Get.put<IAuthenticationRepository>(AuthenticationRepository(Get.find()));
  Get.put(AuthenticationUseCase(Get.find()));

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
