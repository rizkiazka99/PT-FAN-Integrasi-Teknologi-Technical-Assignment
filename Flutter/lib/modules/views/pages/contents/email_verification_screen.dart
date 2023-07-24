import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/email_verification_controller.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/contents/home_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/default_button.dart';
import '../../widgets/custom_snackbar.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    EmailVerificationController controller = Get.find<EmailVerificationController>();

    return Obx(() => !controller.isEmailVerified ? WillPopScope(
      onWillPop: () {
        controller.signOut();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6,
                    left: 15,
                    right: 15,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify your e-mail',
                        style: h3(),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Image.asset(
                          'assets/img/verify_email.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Please verify you e-mail address by clicking the link sent to your e-mail (${controller.firebaseAuth.currentUser!.email})',
                        style: bodyMd(color: textGrey),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      DefaultButton(
                        onTap: () {
                          if (controller.canResendEmail) {
                            controller.sendVerificationEmail();
                            print('canResendEmail: ${controller.canResendEmail}');
                            customSnackbar('Yay!', 'E-mail has been resent');
                          } else {
                            print('canResendEmail: ${controller.canResendEmail}');
                            customSnackbar(
                              'Oops!', 
                              'Please wait for 30 seconds before requesting for another e-mail resend'
                            );
                          }
                        }, 
                        buttonText: 'RESEND'
                      ),
                      const SizedBox(height: 8),
                      DefaultButton(
                        onTap: () {
                          controller.signOut();
                        },
                        buttonColor: contextRed,
                        buttonText: 'SIGN OUT'
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ) : const HomeScreen());
  }
}