import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/client.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';

class ViewReport extends StatefulWidget {
  const ViewReport({super.key});

  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  Report report = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    CoordinatorController coordinatorController = Get.find();
    Client objClient = coordinatorController.getClientById(report.userId);
    SupportUser objSupport = coordinatorController.getSupportById(report.supportId);
    String title = report.title;
    String description = report.description;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(report.startTime);
    int minutes = report.duration;
    String client = "${objClient.firstName} ${objClient.lastName}";
    String support = "${objSupport.firstName} ${objSupport.lastName}";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description:\n$description",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Date:\n${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Duration:\n$minutes minutes",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Client:\n$client",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Support:\n$support",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Rating:",
              style: TextStyle(fontSize: 20),
            ),
            RatingBar.builder(
              initialRating: report.rating,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                coordinatorController.updateReport(report);
              },
            ),
          ],
        ),
      ),
    );
  }
}
