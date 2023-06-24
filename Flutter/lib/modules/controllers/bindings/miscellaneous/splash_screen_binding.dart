import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/miscellaneous/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}