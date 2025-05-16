import 'package:flutter/material.dart';
import 'package:innofast_task/utils/dimensions.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isBorder;
  const CustomCard({super.key, this.child, this.width, this.height, this.borderRadius, this.margin, this.padding, this.isBorder = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity, height: height,
      margin: margin, padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radiusTen),
        border: Border.all(color: Color(0xffF2F2F2), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 0, offset: Offset(0, 5))],
      ),
      child: child,
    );
  }
}