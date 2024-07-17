import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerWidget(
    {required double height,
    required double width,
    required double borderRadius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          color: Colors.grey.shade300,
        )),
  );
}
