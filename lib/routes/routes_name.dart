import 'dart:convert';

import 'package:innofast_task/feature/github/models/repository_model.dart';

class RoutesName {

  static const String splashScreen = '/';
  static const String profileScreen = '/profile-screen';
  static const String repositoryListScreen = '/repository-list-screen';
  static const String repositoryDetailsScreen = '/repository-details-screen';
  static const String noInternetScreen = '/no-internet-screen';

  static String getSplashScreen () => splashScreen;
  static String getProfileScreen () => profileScreen;
  static String getRepositoryListScreen () => repositoryListScreen;
  static String getRepositoryDetailsScreen ({required RepositoryModel? repository}) {
    String repositoryData = 'null';

    if(repository != null) {
      repositoryData = base64Encode(utf8.encode(jsonEncode(repository.toJson())));
    }
    return '$repositoryDetailsScreen?repository=$repositoryData';
  }
  static String getNoInternetScreen () => noInternetScreen;

}
