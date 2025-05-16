import 'package:get/get.dart';
import 'package:innofast_task/api/api_checker.dart';
import 'package:innofast_task/feature/github/models/profile_model.dart';
import 'package:innofast_task/feature/github/models/repository_model.dart';
import 'package:innofast_task/feature/github/repository/github_repository.dart';

class GithubController extends GetxController implements GetxService {
  final GithubRepository githubRepository;
  GithubController({required this.githubRepository});

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  List<RepositoryModel>? _repositoryList;
  List<RepositoryModel>? get repositoryList => _repositoryList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _perPage;
  String? get perPage => _perPage;

  final List<String> _pageList = [];

  int _page = 1;
  int get page => _page;

  Future<void> getProfile() async {
    Response response = await githubRepository.getProfile(username: 'Shahidullah191');
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getRepositoryList({required String page, bool willUpdate = true}) async {
    if (page == '1') {
      _repositoryList = null;
      _page = 1;
      _pageList.clear();
      _isLoading = true;
      if (willUpdate) {
        update();
      }
    }

    if (!_pageList.contains(page)) {
      _pageList.add(page);
      Response response = await githubRepository.getRepositoryList(username: 'Shahidullah191', page: page);
      if (response.statusCode == 200) {
        if (page == '1') {
          _repositoryList = [];
        }
        _repositoryList?.addAll((response.body as List).map((e) => RepositoryModel.fromJson(e)).toList());
        _isLoading = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (_isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void setPage(int page) {
    _page = page;
  }

}