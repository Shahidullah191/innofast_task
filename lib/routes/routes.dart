import 'package:innofast_task/feature/github/screens/profile_screen.dart';
import 'package:innofast_task/feature/github/screens/repository_details_screen.dart';
import 'package:innofast_task/feature/github/screens/repository_list_screen.dart';
import 'package:innofast_task/feature/splash/screens/splash_screen.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [

    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: RoutesName.profileScreen,
      page: () => const ProfileScreen(),
    ),

    GetPage(
      name: RoutesName.repositoryListScreen,
      page: () => const RepositoryListScreen(),
    ),

    GetPage(
      name: RoutesName.repositoryDetailsScreen,
      page: () => const RepositoryDetailsScreen(),
    ),

  ];
}
