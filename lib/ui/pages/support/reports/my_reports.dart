import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/support_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/support/reports/view_my_report.dart';

class MyReports extends StatefulWidget {
  final int id;
  const MyReports({super.key, required this.id});

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  bool isLoading = true;
  SupportController supportController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await supportController.getReportsBySupportId(widget.id);
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
      itemCount: supportController.reports.length,
      itemBuilder: (context, index) {
        Report report = supportController.reports[index];
        return FutureBuilder<dynamic>(
          future: supportController.getSupportById(report.supportId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Card(
                key: UniqueKey(),
                child: const ListTile(
                  title: Text("Charge in progress..."),
                ),
              );
            } else {
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(report.title),
                  tileColor:
                      report.rating > 3.5 ? Colors.green : report.rating > 2.5 ? Colors.yellow : report.rating != -1 ? Colors.redAccent : Colors.grey,
                  trailing: report.rating != -1
                      ? RatingBar.builder(
                          initialRating: report.rating,
                          minRating: 0.5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        )
                      : const Text("Rating pending..."),
                  onTap: () {
                    logInfo("Going to view report ${report.id}");
                    Get.to(() => const ViewMyReport(),
                        arguments: [report, report.id]);
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
