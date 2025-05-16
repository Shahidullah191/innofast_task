import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/no_internet/connectivity_service.dart';
import 'package:innofast_task/common/widgets/custom_snackbar.dart';
import 'package:innofast_task/routes/routes_name.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  Future<void> _checkConnection(BuildContext context) async {
    final bool isConnected = await ConnectivityService.isConnected();

    if (isConnected) {
      showCustomSnackBar('Connected to the Internet', isError: false);
      Get.offAllNamed(RoutesName.getProfileScreen());
    } else {
      showCustomSnackBar('Still no internet connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'You are offline',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please check your internet connection and try again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  _checkConnection(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
