import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/help_and_support_controller.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final HelpAndSupportController helpAndSupportController =
      Get.find<HelpAndSupportController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      helpAndSupportController.getHelpAndSupportDetails();
    });
    super.initState();
  }

  Future<void> _makePhoneCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();
    return Scaffold(
      appBar: customAppBar(context),
      drawer: AppDrawer(context),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: bottomBarController.selectedBottomNavIndex.value,
          onTap: bottomBarController.onItemTappedChangeBottomNavIndex,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.h),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              // Background card
              Positioned.fill(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'For Any Query & Support',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20),
                      child: Column(
                        children: [
                          SupportCardRow(
                            onTap: () {
                              if (helpAndSupportController
                                  .mobileNo.value.isNotEmpty) {
                                _makePhoneCall(
                                    helpAndSupportController.mobileNo.value);
                              }
                            },
                            title: 'Mobile No',
                            image: 'assets/images/landline.png',
                            info: helpAndSupportController
                                    .mobileNo.value.isNotEmpty
                                ? helpAndSupportController.mobileNo.value
                                : "Mobile No. is not available",
                          ),
                          const SizedBox(height: 20),
                          SupportCardRow(
                            onTap: () {},
                            title: 'Email',
                            image: 'assets/images/email.jpg',
                            info:
                                helpAndSupportController.email.value.isNotEmpty
                                    ? helpAndSupportController.email.value
                                    : "Email is not available",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupportCardRow extends StatelessWidget {
  final String title;
  final String image;
  final String info;
  void Function()? onTap;
  SupportCardRow(
      {super.key,
      required this.title,
      required this.image,
      required this.info,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    info,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
