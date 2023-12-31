import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/confirmation_dialog.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/custom_snackbar.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class EmailVerificationController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Timer? timer;

  RxBool _isEmailVerified = false.obs;
  RxBool _canResendEmail = false.obs;

  bool get isEmailVerified => _isEmailVerified.value;
  bool get canResendEmail => _canResendEmail.value;

  set isEmailVerified(bool isEmailVerified) =>
      this._isEmailVerified.value = isEmailVerified;
  set canResendEmail(bool canResendEmail) =>
      this._canResendEmail.value = canResendEmail;

  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    if (firebaseAuth.currentUser != null) {
      isEmailVerified = firebaseAuth.currentUser!.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();

        timer = Timer.periodic(
          const Duration(seconds: 3), 
          (timer) => checkEmailVerified()
        );
      }
    }
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    } else {
      timer = null;
    }
    super.onClose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();

      canResendEmail = false;
      await Future.delayed(const Duration(seconds: 30));
      canResendEmail = true;
    } on FirebaseAuthException catch(err) {
      switch(err.code) {
        case "too-many-requests":
          errorMessage = 'Too many requests, we\'re putting you on a halt for a moment';
          break;
        default:
          errorMessage = 'Something went wrong';
          break;
      }

      customSnackbar('Oops!', errorMessage);
    }
  }

  Future checkEmailVerified() async {
    await firebaseAuth.currentUser!.reload();
    isEmailVerified = firebaseAuth.currentUser!.emailVerified;

    if (isEmailVerified) {
      timer!.cancel();
    }
  }

  signOut() {
    Get.dialog(ConfirmationDialog(
      title: 'Hold up!', 
      content: 'Are you sure you want to log out?', 
      onConfirmation: () async {
        await firebaseAuth.signOut().then((value) => 
          Get.offAllNamed(loginScreenRoute)
        );
      }
    ));
  }
}