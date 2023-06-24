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
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    } else {
      timer = null;
    }
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();

      canResendEmail = false;
      await Future.delayed(const Duration(seconds: 30));
      canResendEmail = true;
    } catch(err) {
      customSnackbar('Oops', err.toString());
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