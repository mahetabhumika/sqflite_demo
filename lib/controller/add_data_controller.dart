import 'package:demo/service/api_helper.dart';
import 'package:demo/widget/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  final titleController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  addData() async {
    try {
      showLoadingDialog();
      var result = await SQLHelper.createItem(
        titleController.value.text,
        descriptionController.value.text,
      );
      debugPrint("Result=============$result");
      hideLoadingDialog();
      Get.back();
    } catch (e) {
      debugPrint("Error==========$e");
    } finally {}
  }

  updateData(int id) async {
    try {
      showLoadingDialog();
      var result = await SQLHelper.updateItem(
        id,
        titleController.value.text,
        descriptionController.value.text,
      );
      debugPrint("Result=============$result");
      hideLoadingDialog();
      Get.back();
    } catch (e) {
      debugPrint("Error==========$e");
    } finally {}
  }
}
