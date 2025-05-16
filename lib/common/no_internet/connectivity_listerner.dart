import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:innofast_task/common/no_internet/connectivity_service.dart';
import 'package:innofast_task/common/no_internet/no_internet_screen.dart';

class ConnectivityListener extends StatefulWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
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
    });
  }

  void _showNoInternetScreen() {
    if (!_isNoInternetScreenShown) {
      _isNoInternetScreenShown = true;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const NoInternetScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Internet Connection'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _popNoInternetScreen() {
    if (_isNoInternetScreenShown && Navigator.canPop(context)) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connected to the Internet'),
          duration: Duration(seconds: 2),
        ),
      );
      _isNoInternetScreenShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
