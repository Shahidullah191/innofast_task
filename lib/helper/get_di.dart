import 'package:innofast_task/api/api_client.dart';
import 'package:innofast_task/feature/github/controller/github_controller.dart';
import 'package:innofast_task/feature/github/repository/github_repository.dart';
import 'package:innofast_task/utils/api.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  /// Core
  Get.lazyPut(() => ApiClient(appBaseUrl: Api.baseUrl));

  /// Repository
  Get.lazyPut(() => GithubRepository(apiClient: Get.find()));

  /// Controller
  Get.lazyPut(() => GithubController(githubRepository: Get.find()));

  Map<String, Map<String, String>> di = {};
  return di;
}
