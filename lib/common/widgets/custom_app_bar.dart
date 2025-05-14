import 'package:innofast_task/utils/dimensions.dart';
import 'package:innofast_task/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final Widget? actionWidget;
  const CustomAppBar({super.key, required this.title, this.backButton = true, this.onBackPressed, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSixteen, fontWeight: FontWeight.w600, color: Theme.of(context).cardColor)),
      centerTitle: true,
      leading: backButton ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : const SizedBox(),
      backgroundColor: Theme.of(context).primaryColor,
      actions: actionWidget != null ? [actionWidget!] : [const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size(1170, 50);
}