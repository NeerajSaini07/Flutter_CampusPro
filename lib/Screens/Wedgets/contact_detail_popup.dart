import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDialog extends StatelessWidget {
  final String mobileNumber;
  final String emailAddress;

  const ContactDialog(
      {required this.mobileNumber, required this.emailAddress, super.key});

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: mobileNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $mobileNumber';
    }
  }

  Future<void> _openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query:
          'subject=Assistance Required for Forgotten Password Credential&body=I hope this message finds you well.\n\nI’m reaching out because I’ve forgotten my password and am unable to access my account. Could you please assist me with resetting my password or provide the necessary credentials to regain access?\n\nThank you for your help!',
    );
    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              splashColor: AppColors.appbuttonColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.r),
              onTap: () => _makePhoneCall().then((value) {
                Navigator.pop(context);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/phone-call.png', // Path to your image
                      color: AppColors.appbuttonColor.withOpacity(0.6),
                      width: 30.w, // Set the width of the image
                      height: 30.w, // Set the height of the image
                      fit: BoxFit.contain, // Adjust the fit as needed
                    ),
                    // Icon(Icons.phone, color: Colors.grey),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Number',
                          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          mobileNumber,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
                splashColor: AppColors.appbuttonColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4.r),
                onTap: () => _openEmail().then((value) {
                      Navigator.pop(context);
                    }),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/email.png', // Path to your image
                        color: AppColors.appbuttonColor.withOpacity(0.6),
                        width: 30.w, // Set the width of the image
                        height: 30.w, // Set the height of the image
                        fit: BoxFit.contain, // Adjust the fit as needed
                      ),
                      // Icon(Icons.email, color: Colors.grey),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 10.sp),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            emailAddress,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            decoration: BoxDecoration(
                color: AppColors.appbuttonColor,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              'OK',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
