import 'package:get/get.dart';
import 'package:innofast_task/api/api_checker.dart';
import 'package:innofast_task/feature/github/models/profile_model.dart';
import 'package:innofast_task/feature/github/repository/github_repository.dart';

class GithubController extends GetxController implements GetxService {
  final GithubRepository githubRepository;
  GithubController({required this.githubRepository});

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  Future<void> getProfile({required String username}) async {
    Response response = await githubRepository.getProfile(username: username);
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}