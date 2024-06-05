import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/reports/view_report.dart';

class ReportsMenu extends StatefulWidget {
  const ReportsMenu({super.key});

  @override
  State<ReportsMenu> createState() => _ReportsMenuState();
}

class _ReportsMenuState extends State<ReportsMenu> {
  bool isLoading = true;
  CoordinatorController coordinatorController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await coordinatorController.getReports();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports List"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
      ? const Center(child: CircularProgressIndicator())
      : Center(child: _getXlistView()),
    );
  }

  Widget _getXlistView() {
    return ListView.builder(
      itemCount: coordinatorController.reports.length,
      itemBuilder: (context, index) {
        Report report = coordinatorController.reports[index];
        return FutureBuilder<dynamic>(
          future: coordinatorController.getSupportById(report.supportId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(report.title),
                  subtitle: const Text("Cargando..."),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewReport(), arguments: [report, report.id]);
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(report.title),
                  subtitle: const Text("Usuario de Soporte eliminado"),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewReport(), arguments: [report, report.id]);
                  },
                ),
              );
            } else {
              SupportUser support = snapshot.data!;
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(report.title),
                  subtitle: Text("${support.firstName} ${support.lastName}"),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewReport(), arguments: [report, report.id]);
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
