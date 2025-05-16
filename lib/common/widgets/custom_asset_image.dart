import 'package:flutter/material.dart';

class CustomAssetImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const CustomAssetImage({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, fit: fit, width: width, height: height, color: color);
  }
}