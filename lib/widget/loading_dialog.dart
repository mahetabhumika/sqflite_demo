import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog() {
  Future.delayed(
    Duration.zero,
    () {
      Get.dialog(
        Center(
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
      );
    },
  );
}

void hideLoadingDialog({bool istrue = false}) {
  Get.back(closeOverlays: istrue);
}
