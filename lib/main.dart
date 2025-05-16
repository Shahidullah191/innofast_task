import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innofast_task/routes/routes.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:innofast_task/utils/app_color.dart';
import 'package:innofast_task/utils/app_constants.dart';
import 'helper/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColor.primary,
        fontFamily: 'Roboto',
      ),
      initialRoute: RoutesName.getSplashScreen(),
      getPages: AppRoutes.appRoutes(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (BuildContext context, widget) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)), child: Material(
          child: SafeArea(
            top: false, bottom: GetPlatform.isAndroid,
            child: Stack(children: [
              widget!,
            ]),
          ),
        ));
      },
    );
  }
}