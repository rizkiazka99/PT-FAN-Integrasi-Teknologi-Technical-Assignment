import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/login_screen_controller.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/auth/register_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/authentication_form.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/decorative_or.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/default_button.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginScreenController controller = Get.find<LoginScreenController>();

    Widget resetPasswordDialog() {
      return Container(
        margin: const EdgeInsets.all(10),
        child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.all(10),
          child: Container(
            //height: MediaQuery.of(context).size.height / 1.6,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ]),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot your password?',
                    style: h3(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/img/forgot_password_art.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Give us your e-mail address so we could send you the password reset link',
                    textAlign: TextAlign.justify,
                    style: bodyMd(color: textGrey),
                  ),
                  const SizedBox(height: 12),
                  AuthenticationForm(
                      formKey: controller.forgetPasswordEmailFormKey,
                      autovalidateMode:
                          controller.autoValidateForgotPasswordEmail,
                      controller: controller.forgetPasswordEmailController,
                      obscureText: false,
                      label: 'E-mail',
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) {
                        bool validate = EmailValidator.validate(value!);

                        if (value.isEmpty) {
                          return 'E-mail field cannot be left empty';
                        } else {
                          if (!validate) {
                            return 'Invalid e-mail address';
                          }
                        }
                      }),
                  const SizedBox(height: 12),
                  DefaultButton(
                      buttonText: 'RESET',
                      buttonColor: primaryColor,
                      onTap: () {
                        Get.closeAllSnackbars();
                        controller.resetPassword();
                      }),
                  const SizedBox(height: 12),
                  DefaultButton(
                      buttonText: 'CANCEL',
                      buttonColor: Colors.red,
                      onTap: () {
                        Get.back();
                      })
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
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
                      //height: MediaQuery.of(context).size.height / 1.9,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 24, right: 24),
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
                              'SIGN IN',
                              style: h3(),
                            ),
                            const SizedBox(height: 20),
                            AuthenticationForm(
                              formKey: controller.loginEmailFormKey, 
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
                              formKey: controller.loginPasswordFormKey, 
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
                                if (value!.isEmpty) {
                                  return 'Password field cannot be left empty';
                                }
                              }
                            )),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 3),
                              child: InkWell(
                                onTap: () {
                                  Get.dialog(resetPasswordDialog());
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: h6(color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            DefaultButton(
                              onTap: () {
                                controller.login();
                              }, 
                              buttonText: 'SIGN IN'
                            ),
                            const SizedBox(height: 10),
                            decorativeOr(context),
                            const SizedBox(height: 10),
                            DefaultButton(
                              onTap: () {
                                Get.to(
                                  const RegisterScreen(),
                                  routeName: registerScreenRoute, 
                                  transition: Transition.downToUp,
                                );
                              },
                              buttonColor: contextGreen,
                              buttonText: 'SIGN UP'
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
    );
  }
}