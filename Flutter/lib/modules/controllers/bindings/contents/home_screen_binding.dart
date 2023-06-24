import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/contents/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}