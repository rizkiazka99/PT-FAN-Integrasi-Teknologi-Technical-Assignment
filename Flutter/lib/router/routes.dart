import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/bindings/auth/email_verification_binding.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/bindings/auth/login_screen_binding.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/bindings/auth/register_screen_binding.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/bindings/contents/home_screen_binding.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/bindings/miscellaneous/splash_screen_binding.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/auth/email_verification_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/auth/login_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/auth/register_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/contents/home_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/miscellaneous/splash_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: splashScreenRoute,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding()
    ),
    GetPage(
      name: loginScreenRoute,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding()
    ),
    GetPage(
      name: registerScreenRoute,
      page: () => const RegisterScreen(),
      binding: RegisterScreenBinding()
    ),
    GetPage(
      name: emailVerificationScreenRoute,
      page: () => const EmailVerificationScreen(),
      binding: EmailVerificationBinding()
    ),
    GetPage(
      name: homeScreenRoute,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding()
    ),
  ];
}