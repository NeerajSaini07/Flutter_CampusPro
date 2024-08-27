import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleSliderWidget extends StatefulWidget {
  const SimpleSliderWidget({super.key});

  @override
  _SimpleSliderWidgetState createState() => _SimpleSliderWidgetState();
}

class _SimpleSliderWidgetState extends State<SimpleSliderWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _messages = [
    'Important Notice! Holiday',
    'Another Important Message',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(Duration(seconds: 10), () {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = (_currentIndex + 1) % _messages.length;
        });
      }
      _startAutoSlide(); // Continue the auto-slide
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 60.h, // Adjust height to accommodate card content
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
        child: PageView.builder(
          controller: _pageController,
          itemCount: null, // Use null to allow infinite scrolling
          itemBuilder: (context, index) {
            // Calculate the actual index for messages
            int actualIndex = index % _messages.length;

            return Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.chat, // Replace with desired icon
                          color: Colors.yellow.shade700,
                          size: 24.sp,
                        ),
                        SizedBox(width: 10.w), // Space between icon and text
                        Text(
                          _messages[actualIndex],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Define the action for the button
                        print('Button Pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appbuttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'View',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index % _messages.length;
            });
          },
        ),
      ),
    );
  }
}
