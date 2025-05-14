import 'package:innofast_task/api/api_client.dart';
import 'package:innofast_task/feature/github/controller/github_controller.dart';
import 'package:innofast_task/feature/github/repository/github_repository.dart';
import 'package:innofast_task/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: Api.baseUrl, sharedPreferences: Get.find()));

  /// Repository
  Get.lazyPut(() => GithubRepository(apiClient: Get.find()));

  /// Controller
  Get.lazyPut(() => GithubController(githubRepository: Get.find()));

  Map<String, Map<String, String>> di = {};
  return di;
}
