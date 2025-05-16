import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/widgets/custom_app_bar.dart';
import 'package:innofast_task/common/widgets/custom_button.dart';
import 'package:innofast_task/common/widgets/custom_network_image.dart';
import 'package:innofast_task/feature/github/controller/github_controller.dart';
import 'package:innofast_task/routes/routes_name.dart';
import 'package:innofast_task/utils/dimensions.dart';
import 'package:innofast_task/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GithubController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Github Profile', backButton: false),
      body: GetBuilder<GithubController>(builder: (githubController) {

        final profile = githubController.profileModel;

        return githubController.profileModel != null ? SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
          child: Column(children: [

            ClipOval(
              child: CustomNetworkImage(
                image: profile?.avatarUrl ?? '',
                width: 100, height: 100,
              ),
            ),
            const SizedBox(height: 16),

            Text(profile?.name ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeTwenty)),
            const SizedBox(height: 8),

            Text(profile?.bio ?? '', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor), textAlign: TextAlign.center),
            const SizedBox(height: 12),

            profile?.location != null ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 18, color: Theme.of(context).disabledColor),
                const SizedBox(width: 4),
                Text(profile?.location ?? '', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
              ],
            ) : const SizedBox(),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _countWidget(title: 'Followers', value: profile?.followers?.toString() ?? '0'),
                _countWidget(title: 'Following', value: profile?.following?.toString() ?? '0'),
                _countWidget(title: 'Repositories', value: profile?.publicRepos?.toString() ?? '0'),
              ],
            ),
            const SizedBox(height: 30),

            CustomButton(
              onTap: () {
                Get.toNamed(RoutesName.getRepositoryListScreen());
              },
              text: 'View Repositories',
            )

          ]),
        ) : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
      }),
    );
  }

  Widget _countWidget({required String title, required String value}) {
    return Column(
      children: [
        Text(value, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeTwenty)),
        const SizedBox(height: 4),
        Text(title, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
      ],
    );
  }
}
