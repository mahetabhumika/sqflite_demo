import 'package:demo/service/api_helper.dart';
import 'package:demo/widget/loading_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DemoController extends GetxController {
  final dataList = List.empty().obs;
  customInit() async {
    await getData();
  }

  getData() async {
    try {
      showLoadingDialog();
      var result = await SQLHelper.getItems();
      debugPrint("Result=============$result");
      if (result != null) {
        dataList.assignAll(result);
      }
    } catch (e) {
      debugPrint("Error==========$e");
    } finally {
      hideLoadingDialog();
    }
  }

  deleteData(int id) async {
    try {
      showLoadingDialog();
      await SQLHelper.deleteItem(
        id,
      );
      hideLoadingDialog();

      Get.back();
      await getData();
    } catch (e) {
      debugPrint("Error==========$e");
    } finally {}
  }
}
