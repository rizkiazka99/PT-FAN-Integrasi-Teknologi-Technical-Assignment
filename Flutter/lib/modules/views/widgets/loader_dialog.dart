import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';

loaderDialog(Widget loaderIcon, String message) {
  return Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      content: Row(
        children: [
          SizedBox(
            width: 75,
            height: 50,
            child: loaderIcon,
          ),
          const Padding(
            padding: EdgeInsets.all(5)
          ),
          Expanded(
            child: Text(
              message,
              style: h5(fontWeight: FontWeight.normal),
              overflow: TextOverflow.fade,
              maxLines: 3,
            ),
          )
        ],
      ),
    ),
    barrierDismissible: true
  );
}