import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/widgets/custom_asset_image.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:innofast_task/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RoutesName.getProfileScreen());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAssetImage(
          image: Images.logo,
          width: 100, height: 100,
          fit: BoxFit.cover,
        )
      ),
    );
  }
}
