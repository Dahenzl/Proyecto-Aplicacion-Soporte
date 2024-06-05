import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    return Obx(
      () => ListView.builder(
      itemCount: coordinatorController.reports.length,
      itemBuilder: (context, index) {
        Report report = coordinatorController.reports[index];
        return FutureBuilder<dynamic>(
          future: coordinatorController.getSupportById(report.supportId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Card(
                key: UniqueKey(),
                child: const ListTile(
                  title: Text("Charge in progress..."),
                ),
              );
            } else if (snapshot.hasError) {
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(report.title),
                  subtitle: const Text("Support User deleted."),
                  tileColor:
                      report.rating > 3.5 ? Colors.green : report.rating > 2.5 ? Colors.yellow : report.rating != -1 ? Colors.redAccent : Colors.grey,
                  trailing: RatingBar.builder(
                    initialRating: report.rating,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (rating) {},
                  ),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewReport(),
                        arguments: [report, report.id]);
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
                  tileColor:
                      report.rating > 3.5 ? Colors.green : report.rating > 2.5 ? Colors.yellow : report.rating != -1 ? Colors.redAccent : Colors.grey,
                  trailing: RatingBar.builder(
                    initialRating: report.rating,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (rating) {},
                  ),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewReport(),
                        arguments: [report, report.id]);
                  },
                ),
              );
            }
          },
        );
      },
    ));
  }
}
