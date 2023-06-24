import 'package:flutter/material.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';

Widget decorativeOr(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: const Divider(color: contextGrey, thickness: 1.5),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 8,
          child: Text(
            'OR',
            style: bodyMd(
              color: contextGrey,
            )
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: const Divider(color: contextGrey, thickness: 1.3),
        ),
      ],
    ),
  );
}