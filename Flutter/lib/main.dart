import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/firebase_options.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PT FAN Integrasi Teknologi - Technical Assignment',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        colorSchemeSeed: primaryColor,
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
      initialRoute: splashScreenRoute,
    );
  }
}
