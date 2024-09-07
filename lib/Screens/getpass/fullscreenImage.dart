// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final image;
  const FullScreenImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Hero(
                tag: 'imageHero',
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0), // Add space at the top and bottom
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/icon/person_icon.png',
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            right: 10.0,
            child: IconButton.outlined(
              color: AppColors.appbuttonColor,
              icon: const Icon(Icons.close, size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
