import 'package:flutter/material.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

class SupportController {
  final List<SelectedListItem> listOfUsers = [
    SelectedListItem(value: "1", name: 'John'),
    SelectedListItem(value: "2", name: 'Alice'),
    SelectedListItem(value: "3", name: 'Bob'),
    SelectedListItem(value: "4", name: 'Emma'),
    SelectedListItem(value: "5", name: 'Michael'),
    SelectedListItem(value: "6", name: 'Sophia'),
    SelectedListItem(value: "7", name: 'William'),
    SelectedListItem(value: "8", name: 'Olivia'),
    SelectedListItem(value: "9", name: 'James'),
    SelectedListItem(value: "10", name: 'Emily'),
  ];

  final TextEditingController userController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController timeLapseController = TextEditingController();

  String? errorMessage;

  void dispose() {
    userController.dispose();
    descriptionController.dispose();
    hourController.dispose();
    timeLapseController.dispose();
  }

  bool validate() {
    if (userController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        hourController.text.isEmpty ||
        timeLapseController.text.isEmpty) {
      errorMessage = 'Please fill in all fields';
      return false;
    }

    final hour = int.tryParse(hourController.text);
    if (hour == null || hour < 0 || hour > 23) {
      errorMessage = 'Hour must be between 0 and 23';
      return false;
    }

    final timeLapse = int.tryParse(timeLapseController.text);
    if (timeLapse == null || timeLapse <= 0) {
      errorMessage = 'Duration must be a positive integer';
      return false;
    }

    errorMessage = null;
    return true;
  }

  void submitData() {
    print('Data submitted successfully!');
  }
}
