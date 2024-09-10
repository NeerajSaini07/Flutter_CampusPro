// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:campuspro/Utilities/colors.dart';

void showChatScreenDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChatScreenDialog();
    },
  );
}

class ChatScreenDialog extends StatelessWidget {
  const ChatScreenDialog({super.key});

// Initialize controller

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 500, // Increased height for better content fit
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(color: AppColors.loginscafoldcoolr),
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chat with',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
                child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                bool isSender = index % 2 ==
                    0; // Define whether the message is sent or received
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  child: Align(
                    alignment:
                        isSender ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.w), // Limit bubble width
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: isSender
                            ? Color.fromARGB(255, 30, 218, 222)
                            : AppColors.appbuttonColor.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: isSender
                              ? Radius.circular(0)
                              : Radius.circular(16),
                          bottomRight: isSender
                              ? Radius.circular(16)
                              : Radius.circular(0),
                        ),
                      ),
                      child: Text(
                        "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),

            // Display the reply message if set

            Container(
              padding: EdgeInsets.all(1),
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.close, size: 16.sp, color: Colors.grey[600]),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Message Input Field
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // controller: _chatController.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.attach_file, color: Colors.blueGrey),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.blueGrey),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {},
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
