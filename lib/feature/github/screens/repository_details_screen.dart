import 'package:flutter/material.dart';
import 'package:innofast_task/common/widgets/custom_app_bar.dart';
import 'package:innofast_task/common/widgets/custom_button.dart';
import 'package:innofast_task/common/widgets/custom_snackbar.dart';
import 'package:innofast_task/feature/github/models/repository_model.dart';
import 'package:innofast_task/utils/app_color.dart';
import 'package:innofast_task/utils/dimensions.dart';
import 'package:innofast_task/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final RepositoryModel repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: repository.name ?? 'Repository Details'),
      body: Column(children: [

        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.paddingSizeFifteen),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              _buildInfoTile('Repository Name', repository.name ?? 'N/A'),
              _buildInfoTile('Owner', repository.owner?.login ?? 'N/A'),
              _buildInfoTile('Visibility', repository.visibility ?? 'Public'),
              _buildInfoTile('Stars', repository.stargazersCount.toString()),
              _buildInfoTile('Watchers', repository.watchersCount.toString()),
              _buildInfoTile('Forks', repository.forksCount.toString()),
              _buildInfoTile('Language', repository.language ?? 'N/A'),
              _buildInfoTile('Issues', repository.openIssuesCount.toString()),
              _buildInfoTile('Created At', _formatDate(repository.createdAt)),
              _buildInfoTile('Last Pushed', _formatDate(repository.pushedAt)),
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: robotoBold),
                  const SizedBox(height: 5),
                  Text(repository.description ?? 'No description available', style: robotoRegular),
                ],
              ),

            ]),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radiusTen),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0)],
          ),
          child: CustomButton(
            text: 'Open in Browser',
            onTap: () {
              if (repository.htmlUrl != null) {
                _launchUrl(repository.htmlUrl!);
              }else{
                showCustomSnackBar('No URL available');
              }
            },
            width: double.infinity,
            height: 50,
          ),
        ),

      ]),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(title, style: robotoMedium)),
          Expanded(flex: 5, child: Text(value, style: robotoRegular.copyWith(color: AppColor.grey))),
        ],
      ),
    );
  }

  String _formatDate(String? dateTime) {
    if (dateTime == null) return 'N/A';
    final date = DateTime.tryParse(dateTime);
    if (date == null) return 'Invalid date';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showCustomSnackBar('Could not launch URL');
    }
  }
}