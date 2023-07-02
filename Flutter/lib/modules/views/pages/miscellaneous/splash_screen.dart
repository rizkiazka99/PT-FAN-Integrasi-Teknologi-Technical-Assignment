import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/miscellaneous/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SplashScreenController controller = Get.find<SplashScreenController>();
    
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  'assets/img/logo.jpg'
                ),
                Text(
                  'TECHNICAL ASSIGNMENT',
                  style: h5(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'by',
                      style: h6(color: Colors.white),
                    ),
                    Text(
                      ' Rizki Azka Fihi Aghnia',
                      style: h6(),
                    ),
                  ],
                ),
                const Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      height: 50,
                      child: SpinKitRipple(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}