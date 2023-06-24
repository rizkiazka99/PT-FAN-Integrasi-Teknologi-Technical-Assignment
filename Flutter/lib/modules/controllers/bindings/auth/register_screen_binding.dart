import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/auth/register_screen_controller.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterScreenController>(() => RegisterScreenController());
  }
}