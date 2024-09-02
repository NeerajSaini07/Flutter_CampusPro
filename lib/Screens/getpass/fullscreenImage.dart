// ignore_for_file: file_names, sized_box_for_whitespace

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
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0, // Position the cross icon at the top
            right: 0.0, // Position the cross icon on the right
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30.0),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
            ),
          ),
        ],
      ),
    );
  }
}
