import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/auth/register_screen.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/pages/contents/email_verification_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const EmailVerificationScreen();
          } else {
            return const RegisterScreen();
          }
        },
      ),
    );
  }
}