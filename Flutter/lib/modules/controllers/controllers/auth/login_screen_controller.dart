import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/custom_snackbar.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/loader_dialog.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();

  final loginEmailFormKey = GlobalKey<FormState>();
  final loginPasswordFormKey = GlobalKey<FormState>();
  final forgetPasswordEmailFormKey = GlobalKey<FormState>();

  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  var autoValidateForgotPasswordEmail = AutovalidateMode.disabled;

  String errorMessage = '';
  String forgetPasswordErrorMessage = '';

  RxBool _isNotVisible = true.obs;
  bool get isNotVisible => _isNotVisible.value;
  set isNotVisible(bool isNotVisible) =>
      this._isNotVisible.value = isNotVisible;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    forgetPasswordEmailController.dispose();
    print('loginScreenController disposed');
  }

  void showAndHidePassword() {
    isNotVisible = !isNotVisible;
  }

  login() async {
    final isEmailValid = loginEmailFormKey.currentState!.validate();
    final isPasswordValid = loginPasswordFormKey.currentState!.validate();

    try {
      if (isEmailValid && isPasswordValid) {
        loaderDialog(
          const SpinKitRipple(color: primaryColor), 
          'Please wait...'
        );

        await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        ).then((value) => Get.offAllNamed(emailVerificationScreenRoute));
      } else if (!isEmailValid) {
        autoValidateEmail = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePassword = AutovalidateMode.always;
      } else {
        autoValidateEmail = AutovalidateMode.always;
        autoValidatePassword = AutovalidateMode.always;
      }
    } on FirebaseAuthException catch(e) {
      switch(e.code) {
        case "wrong-password":
          errorMessage = 'Invalid e-mail address or password';
          break;
        case "user-not-found":
          errorMessage = 'E-mail address isn\'t registered to any account';
          break;
        case "user-disabled":
          errorMessage = "This account has been deactivated";
          break;
        case "operation-not-allowed":
          errorMessage = "Too many requests, please wait a moment";
          break;
        case "invalid-email":
          errorMessage = "Invalid e-mail address";
        case "network-request-failed":
          errorMessage = "Login failed, no internet connection available";
          break;
        default:
          errorMessage = "Login failed, please try again";
          break;
      }

      Get.back();
      return customSnackbar('Oops!', errorMessage);
    }
  }

  resetPassword() async {
    try {
      final isForgotPasswordEmailValid = forgetPasswordEmailFormKey.currentState!.validate();

      if (isForgotPasswordEmailValid) {
        loaderDialog(
          const SpinKitRipple(color: primaryColor), 
          'Please wait...'
        );

        await firebaseAuth.sendPasswordResetEmail(
          email: forgetPasswordEmailController.text
        ).then((value) => Get.back());
        Get.back();
        customSnackbar(
          'Yay!',
          'Password reset link has been sent to ${forgetPasswordEmailController.text}, please check your Spam if it\'s not in your Inbox'
        );
        forgetPasswordEmailController.clear();
      } else {
        autoValidateForgotPasswordEmail = AutovalidateMode.always;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          forgetPasswordErrorMessage = 'E-mail address isn\'t registered to any account';
          break;
        case "user-disabled":
          forgetPasswordErrorMessage = "This account has been deactivated";
          break;
        case "operation-not-allowed":
          forgetPasswordErrorMessage = "Too many requests, please wait a moment";
          break;
        case "network-request-failed":
          forgetPasswordErrorMessage = "Request failed, no internet connection available";
          break;
        default:
          forgetPasswordErrorMessage = 'Request failed, please try again';
          break;
      }

      Get.back();
      return customSnackbar('Oops!', forgetPasswordErrorMessage);
    }
  }
}