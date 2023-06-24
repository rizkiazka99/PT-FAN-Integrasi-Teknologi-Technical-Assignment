import 'package:flutter/material.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';

class AuthenticationForm extends StatefulWidget {
  final Key? formKey;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType input;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AuthenticationForm({
    super.key, 
    required this.formKey, 
    required this.autovalidateMode, 
    required this.controller, 
    this.obscureText = false, 
    this.input = TextInputType.text, 
    this.minLines = 1, 
    this.maxLines = 1,
    this.maxLength,
    required this.label,
    this.prefixIcon,
    this.suffixIcon, 
    required this.validator,
    this.onChanged
  });

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.input,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.label,
          counterText: '',
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
          errorMaxLines: 3,
          labelStyle: h5(
            color: primaryColor,
            fontWeight: FontWeight.normal
          ),
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: primaryColor,
              width: 2
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextRed,
              width: 2
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: contextRed,
              width: 2
            )
          )
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      )
    );
  }
}