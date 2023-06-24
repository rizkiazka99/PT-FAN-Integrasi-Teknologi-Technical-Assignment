import 'package:flutter/material.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? buttonColor;
  final String buttonText;
  
  const DefaultButton({
    super.key, 
    required this.onTap,
    this.buttonColor = primaryColor,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: buttonColor
          ),
          child: Center(
            child: Text(
              buttonText,
              style: buttonLg(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}