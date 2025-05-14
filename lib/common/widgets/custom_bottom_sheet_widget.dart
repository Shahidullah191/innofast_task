import 'package:innofast_task/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomBottomSheet({required Widget child, double? maxHeight}) {
  showModalBottomSheet(
    isScrollControlled: true, useRootNavigator: true, context: Get.context!,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusTwenty), topRight: Radius.circular(Dimensions.radiusTwenty)),
    ),
    builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8),
        child: child,
      );
    },
  );
}