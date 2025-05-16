import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/widgets/custom_app_bar.dart';
import 'package:innofast_task/common/widgets/custom_card.dart';
import 'package:innofast_task/feature/github/controller/github_controller.dart';
import 'package:innofast_task/feature/github/models/repository_model.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:innofast_task/utils/dimensions.dart';
import 'package:innofast_task/utils/styles.dart';

class RepositoryListScreen extends StatefulWidget {
  const RepositoryListScreen({super.key});

  @override
  State<RepositoryListScreen> createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<GithubController>().getRepositoryList(page: '1', willUpdate: false);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Get.find<GithubController>().showBottomLoader();
      Get.find<GithubController>().setPage(Get.find<GithubController>().page + 1);
      Get.find<GithubController>().getRepositoryList(page: Get.find<GithubController>().page.toString());
    }
  }

  void _onRefresh() async {
    await Get.find<GithubController>().getRepositoryList(page: '1');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Public Repositories'),
      body: GetBuilder<GithubController>(builder: (githubController) {
        return githubController.repositoryList != null ? githubController.repositoryList!.isNotEmpty ? RefreshIndicator(
          onRefresh: () async{
            _onRefresh();
          },
          child: ListView.builder(
            padding: EdgeInsets.all(Dimensions.paddingSizeFifteen),
            controller: _scrollController,
            itemCount: githubController.repositoryList!.length + (githubController.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < githubController.repositoryList!.length) {
                return _buildRepositoryItem(githubController.repositoryList![index]);
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeFifteen),
                  child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
                );
              }
            },
          ),
        ) : const Center(child: Text('No repositories found')) : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
      }),
    );
  }

  Widget _buildRepositoryItem(RepositoryModel repository) {
    return CustomCard(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeTen),
      child: InkWell(
        onTap: () {
          Get.toNamed(RoutesName.getRepositoryDetailsScreen(repository: repository));
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(
              repository.name ?? 'No name',
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSixteen),
            ),
            const SizedBox(height: 8),

            Text(
              repository.description ?? 'No description available',
              style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 8),

            Row(children: [

              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(repository.stargazersCount.toString()),
                ],
              ),
              const SizedBox(width: 16),

              Row(
                children: [
                  const Icon(Icons.code, size: 16),
                  const SizedBox(width: 4),
                  Text(repository.language ?? 'No language'),
                ],
              ),

            ]),

          ]),
        ),
      ),
    );
  }

}
