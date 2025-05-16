import 'package:get/get.dart';
import 'package:innofast_task/api/api_client.dart';
import 'package:innofast_task/utils/api.dart';

class GithubRepository {
  final ApiClient apiClient;
  GithubRepository({required this.apiClient});

  Future<Response> getProfile({required String username}) async {
    return await apiClient.getData('${Api.userUri}/$username');
  }

  Future<Response> getRepositoryList({required String username, required String page}) async {
    final url = '${Api.userUri}/$username/repos?per_page=10&page=$page';
    return await apiClient.getData(url);
  }

}