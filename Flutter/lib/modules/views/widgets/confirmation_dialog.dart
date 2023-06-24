import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/default_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onConfirmation;
  
  const ConfirmationDialog({
    super.key, 
    required this.title, 
    required this.content, 
    required this.onConfirmation
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
      title: Text(
        title,
        style: h5(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        style: bodyMd(color: textGrey),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DefaultButton(
                onTap: onConfirmation,
                buttonText: 'Yes',
                buttonColor: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: DefaultButton(
                onTap: () {
                  Get.back();
                },
                buttonText: 'No',
                buttonColor: contextRed
              ),
            )
          ],
        )
      ],
    );
  }
}