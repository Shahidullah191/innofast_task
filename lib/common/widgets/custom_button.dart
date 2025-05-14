import 'package:innofast_task/utils/dimensions.dart';
import 'package:innofast_task/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Color? color;
  final Color? textColor;
  final Function()? onTap;
  final bool isLoading;
  final bool isBorder;
  const CustomButton({super.key, this.height = 50, this.width, required this.text, this.color, this.textColor, this.onTap, this.isLoading = false, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusFifteen),
          border: isBorder ? Border.all(color: Theme.of(context).disabledColor.withValues(alpha: 0.1), width: 1.5) : null,
        ),
        child: Center(
          child: isLoading ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 15, width: 15,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeTen),

            Text('Loading', style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeSixteen)),
          ]) : Text(text, style: robotoBold.copyWith(color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeSixteen)),
        ),
      ),
    );
  }
}
