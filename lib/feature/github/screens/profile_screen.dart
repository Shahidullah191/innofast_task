import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innofast_task/common/widgets/custom_app_bar.dart';
import 'package:innofast_task/feature/github/controller/github_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GithubController>().getProfile(username: 'Shahidullah191');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Github Profile', backButton: false),
      body: GetBuilder<GithubController>(builder: (githubController) {

        final profile = githubController.profileModel;

        return githubController.profileModel != null ? SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profile?.avatarUrl ?? ''),
              ),
              const SizedBox(height: 16),
              Text(profile?.name ?? '', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (profile?.bio != null)
                Text(profile!.bio!, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              if (profile?.location != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 4),
                    Text(profile!.location!),
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('Followers', profile?.followers?.toString() ?? '0'),
                  _buildStat('Following', profile?.following?.toString() ?? '0'),
                  _buildStat('Repos', profile?.publicRepos?.toString() ?? '0'),
                ],
              ),
            ],
          ),
        ) : const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
