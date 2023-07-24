import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/colors.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/core/values/font_sizes.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/controllers/controllers/contents/home_screen_controller.dart';
import 'package:pt_fan_integrasi_teknologi_assignment/modules/models/user_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.find<HomeScreenController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.8),
                  color: primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.logout();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 16),
                                child: Icon(
                                  Icons.logout_outlined,
                                  color: contextRed,
                                  size: 35,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'SIGN OUT',
                                          style: h4(),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: contextGrey,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 25),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)
                    ),
                    color: backgroundColorPrimary
                  ),
                  child: StreamBuilder<UserResponse>(
                    stream: controller.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Column(
                          children: [
                            const Icon(
                              Icons.error,
                              color: contextRed,
                            ),
                            Text(
                              'Something went wrong!',
                              style: h5(),
                            )
                          ],
                        );
                      } else {
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 4,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: contextGreen
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data!.name[0].toUpperCase(),
                                    style: h1()
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.name,
                                        style: h2(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                      Text(
                                        snapshot.data!.email,
                                        style: h6(fontWeight: FontWeight.normal),
                                        maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: controller.firebaseAuth.currentUser!.emailVerified
                                              ? contextGreen : contextRed,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.firebaseAuth.currentUser!.emailVerified
                                                ? 'VERIFIED' : 'UNVERIFIED',
                                            style: h6(
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}