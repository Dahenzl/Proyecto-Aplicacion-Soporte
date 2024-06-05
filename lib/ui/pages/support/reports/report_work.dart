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

  final TextEditingController userController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController timeLapseController = TextEditingController();
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDateTime;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  Future<void> fetchClients() async {
    await _controller.fetchClients();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Report'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      _buildTextField('Client', 'Select a client', userController, true),
                      const SizedBox(height: 20.0),
                      _buildTextField('Title', 'Enter the title', titleController, false),
                      const SizedBox(height: 20.0),
                      _buildTextField('Description', 'Enter the description', descriptionController, false, maxLines: 5),
                      const SizedBox(height: 20.0),
                      _buildDateTimeField(),
                      const SizedBox(height: 20.0),
                      _buildTextField('Duration', 'Enter the duration (minutes)', timeLapseController, false),
                      const SizedBox(height: 20.0),
                      if (errorMessage != null)
                        Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _controller.createReport(
                                title: titleController.text,
                                description: descriptionController.text,
                                startTime: _selectedDateTime!.millisecondsSinceEpoch,
                                duration: int.parse(timeLapseController.text),
                                userId: int.parse(userController.text),
                                supportId: 1, // Assuming current support user ID is 1
                              );
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Send'),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(String title, String hint, TextEditingController controller, bool isDropDown, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
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
          keyboardType: isDropDown ? TextInputType.text : TextInputType.number,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            hintText: hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $title';
            }
            if (title == 'Duration') {
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date and Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5.0),
        InkWell(
          onTap: () => _selectDateTime(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Text(
              _selectedDateTime == null
                  ? 'Select date and time'
                  : '${_selectedDateTime!.toLocal()}'.split(' ')[0] +
                      ' ' +
                      '${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTextFieldTap() {
  if (_controller.clients.isEmpty) {
    _controller.fetchClients();
  }
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
      data: _controller.clients.map((client) {
        return SelectedListItem(value: client.id.toString(), name: client.id.toString());
      }).toList(),
      selectedItems: (List<dynamic> selectedList) {
        if (selectedList.isNotEmpty && selectedList[0] is SelectedListItem) {
          final SelectedListItem selectedItem = selectedList[0];
          userController.text = selectedItem.name;
        }
      },
      enableMultipleSelection: false,
    ),
  ).showModal(context);
}


}
