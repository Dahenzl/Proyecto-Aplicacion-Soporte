import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
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
  late Future<void> _future;
  late Report report;
  late String title = "";
  late String description = "";
  late DateTime date = DateTime.now();
  late int minutes = 0;
  late String client = "";
  late String support = "";
  late double rating = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    report = Get.arguments[0];
    _initializeData();
  }

  Future<void> _initializeData() async {
    CoordinatorController coordinatorController = Get.find();
    setState(() {
      date = DateTime.fromMillisecondsSinceEpoch(report.startTime);
      minutes = report.duration;
      rating = report.rating;
      title = report.title;
      description = report.description;
    });
    try {
      Client objClient =
          await coordinatorController.getClientById(report.userId);

      setState(() {
        client = "${objClient.firstName} ${objClient.lastName}";
      });
    } catch (error) {
      // Handle any errors here
      setState(() {
        client = "Usuario de Cliente eliminado";
      });
    }
    try {
      SupportUser objSupport =
          await coordinatorController.getSupportById(report.supportId);
      setState(() {
        support = "${objSupport.firstName} ${objSupport.lastName}";
      });
    } catch (error) {
      // Handle any errors here
      setState(() {
        support = "Usuario de Soporte eliminado";
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while data is loading
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text("Description:\n$description",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text(
                      "Date:\n${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text("Duration:\n$minutes minutes",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text("Client:\n$client",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text("Support:\n$support",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  const Text("Your Rating:", style: TextStyle(fontSize: 20)),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) async {
                      setState(() {
                        rating = newRating;
                      });
                      CoordinatorController coordinatorController = Get.find();
                      report.rating = newRating;
                      logInfo("Updating report rating to ${report.id}");
                      await coordinatorController.updateReport(report);
                      Get.snackbar("Success", "Rating updated successfully to $newRating stars",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
