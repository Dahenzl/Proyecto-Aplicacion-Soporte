import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/reports/view_report.dart';

class ReportsMenu extends StatefulWidget {
  const ReportsMenu({super.key});

  @override
  State<ReportsMenu> createState() => _ReportsMenuState();
}

class _ReportsMenuState extends State<ReportsMenu> {
  CoordinatorController coordinatorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports List"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(child: _getXlistView()),
    );
  }

  Widget _getXlistView() {
    return ListView.builder(
      itemCount: coordinatorController.reports.length,
      itemBuilder: (context, index) {
        Report report = coordinatorController.reports[index];
        return Card(
          key: UniqueKey(),
          child: ListTile(
            title: Text(report.title),
            subtitle:
                Text("${report.client.firstName} ${report.client.lastName}"),
            onTap: () {
              logInfo("Going to view report ${report.id}");
              Get.to(() => const ViewReport(), arguments: [report, report.id]);
            },
          ),
        );
      },
    );
  }
}
