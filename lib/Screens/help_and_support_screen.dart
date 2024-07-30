import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'For Any Query & Support',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: _SupportCard(
                            title: 'Landline',
                            image: 'assets/images/landline.png',
                            info: '01285 221533',
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: _SupportCard(
                            title: 'Web Support',
                            image: 'assets/images/websupport.png',
                            info: '9891009907',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                    child: Column(
                      children: [
                        _SupportCardRow(
                          title: 'Email',
                          image: 'assets/images/email.jpg',
                          info: 'Enablesoftggn@gmail.com',
                        ),
                        SizedBox(height: 20),
                        _ERPSupportCard(
                          title: 'ERP Support',
                          info: [
                            '9891009944',
                            '9891009943',
                            '9599773499',
                          ],
                        ),
                      ],
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

class _SupportCard extends StatelessWidget {
  final String title;
  final String image;
  final String info;
  final double? width;

  const _SupportCard({
    super.key,
    required this.title,
    required this.image,
    required this.info,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: 150,
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 60,
              width: 50,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              info,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCardRow extends StatelessWidget {
  final String title;
  final String image;
  final String info;

  const _SupportCardRow({
    super.key,
    required this.title,
    required this.image,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
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
    );
  }
}

class _ERPSupportCard extends StatelessWidget {
  final String title;
  final List<String> info; // Update to List<String>

  const _ERPSupportCard({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
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
          const SizedBox(
            width: double.infinity,
            height: 10,
          ),
          Column(
            children: [
              Wrap(
                // Use Wrap for flexibility in case numbers overflow
                spacing: 5, // Spacing between items
                children: info
                    .map((number) => GestureDetector(
                          onTap: () => _makePhoneCall(number),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              // Size only as big as needed
                              children: [
                                const Icon(Icons.call,
                                    size: 20,
                                    color: const Color.fromARGB(255, 8, 6, 6)),
                                const SizedBox(width: 4),
                                Text(
                                  number,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 18, 15, 15)),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
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
}
