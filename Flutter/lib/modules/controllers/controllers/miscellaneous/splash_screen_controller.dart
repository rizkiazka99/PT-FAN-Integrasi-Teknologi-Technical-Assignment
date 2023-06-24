import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class SplashScreenController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    print('User: ${firebaseAuth.currentUser}');
    loading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  firstPage() {
    if (firebaseAuth.currentUser != null) {
      Get.offAllNamed(homeScreenRoute);
    } else {
      Get.offAllNamed(loginScreenRoute);
    }
  }

  loading() {
    print('loading started');
    return Timer(
      const Duration(seconds: 3),
      firstPage
    );
  }
}