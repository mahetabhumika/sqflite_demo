import 'package:demo/controller/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataScreen extends StatefulWidget {
  final bool isEdit;
  final int id;
  const AddDataScreen({super.key, required this.isEdit, required this.id});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final addDataController = Get.put(AddDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(
          widget.isEdit == true ? "Edit" : "Add",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: addDataController.titleController.value,
              decoration: const InputDecoration(
                hintText: "Enter Title",
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                labelText: "Title",
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: addDataController.descriptionController.value,
              decoration: const InputDecoration(
                hintText: "Enter description",
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                labelText: "Description",
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () async {
                if (widget.isEdit == true) {
                  await addDataController.updateData(widget.id);
                } else {
                  await addDataController.addData();
                }
              },
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.isEdit == true ? "Save" : "Submit",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
