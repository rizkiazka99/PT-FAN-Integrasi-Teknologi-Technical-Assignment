import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/login_screen_controller.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/register_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}