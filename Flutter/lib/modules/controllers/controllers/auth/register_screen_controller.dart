import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/custom_snackbar.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/loader_dialog.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class RegisterScreenController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final registerEmailFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final registerPasswordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();
  
  var autoValidateEmail = AutovalidateMode.disabled;
  var autoValidateName = AutovalidateMode.disabled;
  var autoValidatePassword = AutovalidateMode.disabled;
  var autoValidateConfirmPassword = AutovalidateMode.disabled;

  String errorMessage = '';

  RxInt _nameLength = 0.obs;
  RxBool _isNotVisible = true.obs;
  RxBool _isConfirmPasswordNotVisible = true.obs;

  int get nameLength => _nameLength.value;
  bool get isNotVisible => _isNotVisible.value;
  bool get isConfirmPasswordNotVisible => _isConfirmPasswordNotVisible.value;

  set nameLength(int nameLength) =>
      this._nameLength.value = nameLength;
  set isNotVisible(bool isNotVisible) =>
      this._isNotVisible.value = isNotVisible;
  set isConfirmPasswordNotVisible(bool isConfirmPasswordNotVisible) =>
      this._isConfirmPasswordNotVisible.value = isConfirmPasswordNotVisible;

  @override
  void onInit() {
    emailController = TextEditingController();
    nameController  = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
    print('registerScreenController disposed');
  }

  void showAndHidePassword() {
    isNotVisible = !isNotVisible;
  }

  void showAndHideConfirmPassword() {
    isConfirmPasswordNotVisible = !isConfirmPasswordNotVisible;
  }

  Future<void> userSetup(String name, String email) async {
    String uid = firebaseAuth.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(uid).set({
      'name' : name,
      'email' : email
    });
  } 

  signup() async {
    try {
      final isNameValid = nameFormKey.currentState!.validate();
      final isEmailValid = registerEmailFormKey.currentState!.validate();
      final isPasswordValid = registerPasswordFormKey.currentState!.validate();
      final isConfirmedPasswordValid = confirmPasswordFormKey.currentState!.validate();

      if (isNameValid && isEmailValid && isPasswordValid && isConfirmedPasswordValid) {
        loaderDialog(
          const SpinKitRipple(color: primaryColor), 
          'Please Wait...'
        );

        await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        ).then((value) {
          User? updateUser = firebaseAuth.currentUser;
          updateUser!.updateDisplayName(nameController.text);
          userSetup(nameController.text, emailController.text);
          Get.offAllNamed(emailVerificationScreenRoute);
          customSnackbar('Yay!', 'Account created successfully, welcome!');
        });
      } else if (!isNameValid) {
        autoValidateName = AutovalidateMode.always;
      } else if (!isEmailValid) {
        autoValidateEmail = AutovalidateMode.always;
      } else if (!isPasswordValid) {
        autoValidatePassword = AutovalidateMode.always;
      } else if (!isConfirmedPasswordValid) {
        autoValidateConfirmPassword = AutovalidateMode.always;
      } else {
        autoValidateName = AutovalidateMode.always;
        autoValidateEmail = AutovalidateMode.always;
        autoValidatePassword = AutovalidateMode.always;
        autoValidateConfirmPassword = AutovalidateMode.always;
      }
    } on FirebaseAuthException catch(error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "E-mail address is already in use";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Invalid e-mail address";
          break;
        case "network-request-failed":
          errorMessage = "Account creation failed, no internet connection available";
          break;
        default:
          errorMessage = "Account creation failed, please try again";
          break;
      }
      
      Get.back();
      return customSnackbar('Oops!', errorMessage);     
    }
  }
}