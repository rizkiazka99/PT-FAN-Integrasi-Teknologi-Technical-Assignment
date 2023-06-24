import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/models/user_response.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/views/widgets/confirmation_dialog.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/router/route_names.dart';

class HomeScreenController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late DatabaseReference dbRef;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String uid = '';

  @override
  void onInit() {
    super.onInit();
    dbRef = FirebaseDatabase.instance.ref();
    uid = firebaseAuth.currentUser!.uid;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<UserResponse> getUserData() => firestore.collection('users')
      .doc(uid)
      .snapshots()
      .map((snapshot) => UserResponse.fromJson(snapshot.data()!));

  logout() {
    Get.dialog(ConfirmationDialog(
      title: 'Hold up!', 
      content: 'Are you sure you want to log out of your account?', 
      onConfirmation: () async {
        await firebaseAuth.signOut().then((value) => 
          Get.offAllNamed(loginScreenRoute)
        );
      }
    ));
  }
}