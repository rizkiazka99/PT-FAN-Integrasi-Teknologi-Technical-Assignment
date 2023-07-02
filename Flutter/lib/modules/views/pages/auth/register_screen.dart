import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/helpers/regex.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/register_screen_controller.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/authentication_form.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/confirmation_dialog.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/default_button.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';
import '../../../../core/values/font_sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    RegisterScreenController controller = Get.put(RegisterScreenController());

    return WillPopScope(
      onWillPop: () {  
        if (controller.emailController.text.isNotEmpty || controller.nameController.text.isNotEmpty 
              || controller.passwordController.text.isNotEmpty 
              || controller.confirmPasswordController.text.isNotEmpty) {
            Get.dialog(ConfirmationDialog(
              title: 'Hold up!', 
              content: 'Are you sure you want to cancel your account creation?', 
              onConfirmation: () {
                //Get.offNamed(loginScreenRoute);
                Get.back();
                Get.back();
              }
            ));
            return Future.value(false);
        } else {
          Get.back();
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)
                          )
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/img/logo.jpg'
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Container(
                        //height: MediaQuery.of(context).size.height / 1.55,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 90, left: 24, right: 24),
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor,
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3)
                            )
                          ]
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIGN UP',
                                style: h3(),
                              ),
                              const SizedBox(height: 20),
                              AuthenticationForm(
                                formKey: controller.nameFormKey, 
                                autovalidateMode: controller.autoValidateName, 
                                controller: controller.nameController, 
                                label: 'Name',
                                prefixIcon: const Icon(
                                  Icons.account_box
                                ),
                                maxLength: 50,
                                suffixIcon: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width / 8,
                                  padding: const EdgeInsets.only(left: 3, right: 6),
                                  child: Obx(() => Text(
                                    '${controller.nameLength}/50',
                                    style: bodyMd(),
                                  )),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name field cannot be left empty';
                                  } else {
                                    if (value.length < 3) {
                                      return 'Name has to be at least 3 characters long';
                                    } else if (value.length > 50) {
                                      return 'Name cannot be more than 50 characters long';
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  controller.nameLength = value.length;
                                },
                              ),
                              const SizedBox(height: 15),
                              AuthenticationForm(
                                formKey: controller.registerEmailFormKey, 
                                autovalidateMode: controller.autoValidateEmail, 
                                controller: controller.emailController, 
                                label: 'Email',
                                prefixIcon: const Icon(
                                  Icons.email_rounded
                                ),
                                validator: (value) {
                                  bool validate = EmailValidator.validate(value!);
                        
                                  if (value.isEmpty) {
                                    return 'E-mail field cannot be left empty';
                                  } else {
                                    if (!validate) {
                                      return 'Invalid E-mail address';
                                    }
                                  }
                                }
                              ),
                              const SizedBox(height: 15),
                              Obx(() => AuthenticationForm(
                                formKey: controller.registerPasswordFormKey, 
                                autovalidateMode: controller.autoValidatePassword, 
                                controller: controller.passwordController, 
                                label: 'Password',
                                obscureText: controller.isNotVisible,
                                prefixIcon: const Icon(
                                  Icons.lock
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.showAndHidePassword();
                                  },
                                  icon: Icon(controller.isNotVisible == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                validator: (value) {
                                  bool validate = CustomRegEx.validatePassword(value!);
            
                                  if (value.isEmpty) {
                                    return 'Password field cannot be left empty';
                                  } else {
                                    if (!validate) {
                                      return 'Password needs to consist of at least 8 characters and contain at least 1 numeric character and 1 uppercase character';
                                    }
                                  }
                                }
                              )),
                              const SizedBox(height: 15),
                              Obx(() => AuthenticationForm(
                                formKey: controller.confirmPasswordFormKey, 
                                autovalidateMode: controller.autoValidateConfirmPassword, 
                                controller: controller.confirmPasswordController, 
                                label: 'Confirm Password',
                                obscureText: controller.isConfirmPasswordNotVisible,
                                prefixIcon: const Icon(
                                  Icons.lock
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.showAndHideConfirmPassword();
                                  },
                                  icon: Icon(controller.isConfirmPasswordNotVisible == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Confirm Password field cannot be left empty';
                                  } else {
                                    if (value != controller.passwordController.text) {
                                      return 'Password wasn\'t confirmed';
                                    }
                                  }
                                }
                              )),
                              const SizedBox(height: 15),
                              DefaultButton(
                                onTap: () {
                                  controller.signup();
                                }, 
                                buttonText: 'SIGN UP'
                              ),
                              const SizedBox(height: 10),
                              DefaultButton(
                                onTap: () {
                                  if (controller.emailController.text.isNotEmpty || controller.nameController.text.isNotEmpty 
                                        || controller.passwordController.text.isNotEmpty 
                                        || controller.confirmPasswordController.text.isNotEmpty) {
                                      Get.dialog(ConfirmationDialog(
                                        title: 'Hold up!', 
                                        content: 'Are you sure you want to cancel your account creation?', 
                                        onConfirmation: () {
                                          //Get.offNamed(loginScreenRoute);
                                          Get.back();
                                          Get.back();
                                        }
                                      ));
                                  } else {
                                    Get.back();
                                  }
                                },
                                buttonColor: contextRed,
                                buttonText: 'CANCEL'
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}