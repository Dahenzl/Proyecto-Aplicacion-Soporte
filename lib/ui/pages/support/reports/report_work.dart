import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:get/get.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import '../../../controller/support_controller.dart';

class SendReports extends StatefulWidget {
  const SendReports({Key? key}) : super(key: key);

  @override
  _SendReportsState createState() => _SendReportsState();
}

class _SendReportsState extends State<SendReports> {
  final SupportController _controller = SupportController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Report"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              _buildTextField('Client', 'Select a client',
                  _controller.userController, true),
              const SizedBox(height: 20.0),
              _buildTextField('Title', 'Enter the title',
                  _controller.titleController, false),
              const SizedBox(height: 20.0),
              _buildTextField('Description', 'Enter the description',
                  _controller.descriptionController, false,
                  maxLines: 5),
              const SizedBox(height: 20.0),
              _buildTextField('Hour', 'Enter the hour (0-23)',
                  _controller.hourController, false),
              const SizedBox(height: 20.0),
              _buildTextField('Duration', 'Enter the duration (minutes)',
                  _controller.timeLapseController, false),
              const SizedBox(height: 20.0),
              if (_controller.errorMessage != null)
                Text(
                  _controller.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.validate()) {
                      _controller.submitData();
                      Get.back();
                    }
                  },
                  child: Text('Send'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String title, String hint,
      TextEditingController controller, bool isDropDown,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          readOnly: isDropDown,
          onTap: isDropDown ? _onTextFieldTap : null,
          keyboardType: TextInputType.number,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 15.0), // Adjust padding here
            hintText: hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Users',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _controller.listOfUsers,
        selectedItems: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty && selectedList[0] is SelectedListItem) {
            final SelectedListItem selectedItem = selectedList[0];
            _controller.userController.text = selectedItem.name;
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }
}
