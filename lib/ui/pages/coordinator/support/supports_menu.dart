import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/support_user.dart';
import 'package:proyecto_aplicacion_soporte/ui/controller/coordinator_controller.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/support/create_support.dart';
import 'package:proyecto_aplicacion_soporte/ui/pages/coordinator/support/edit_support.dart';

class SupportsMenu extends StatefulWidget {
  const SupportsMenu({super.key});

  @override
  State<SupportsMenu> createState() => _SupportsMenuState();
}

class _SupportsMenuState extends State<SupportsMenu> {
  CoordinatorController coordinatorController = Get.find();

  @override
  Widget build(BuildContext context) {
    coordinatorController.getSupports();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support List"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(child: _getXlistView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("Add support from UI");
          Get.to(() => const CreateSupport());
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getXlistView() {
    return Obx(
      () => ListView.builder(
        itemCount: coordinatorController.supports.length,
        itemBuilder: (context, index) {
          SupportUser support = coordinatorController.supports[index];
          return Card(
            key: UniqueKey(),
            child: ListTile(
              title: Text("${support.firstName} ${support.lastName}"),
              subtitle: Text(support.email),
              onTap: () {
                Get.to(() => const EditSupport(),
                    arguments: [support, support.id]);
              },
            ),
          );
        },
      ),
    );
  }
}
