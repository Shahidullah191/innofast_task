import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/no_internet/connectivity_service.dart';
import 'package:innofast_task/common/widgets/custom_asset_image.dart';
import 'package:innofast_task/common/widgets/custom_snackbar.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:innofast_task/utils/app_color.dart';
import 'package:innofast_task/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _wasConnected = true;
  bool _isNoInternetScreenShown = false;

  @override
  void initState() {
    super.initState();

    ConnectivityService.connectivityStream.listen((results) {
      final isConnected = !results.contains(ConnectivityResult.none);

      if (!isConnected && _wasConnected) {
        _wasConnected = false;
        _showNoInternetScreen();
      } else if (isConnected && !_wasConnected) {
        _wasConnected = true;
        _popNoInternetScreen();
      }

      if (isConnected) {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(RoutesName.getProfileScreen());
        });
      }

    });
  }

  void _showNoInternetScreen() {
    if (!_isNoInternetScreenShown) {
      _isNoInternetScreenShown = true;
      Get.offAllNamed(RoutesName.getNoInternetScreen());
      showCustomSnackBar('No Internet Connection');
    }
  }

  void _popNoInternetScreen() {
    if (_isNoInternetScreenShown) {
      Get.offAllNamed(RoutesName.getProfileScreen());
      showCustomSnackBar('Connected to the Internet', isError: false);
      _isNoInternetScreenShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
