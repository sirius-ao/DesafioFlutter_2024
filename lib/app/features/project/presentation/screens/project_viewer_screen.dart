import 'package:flutter/material.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';
import 'package:project_management_app/app/core/utils/calculate_reading_time.dart';
import 'package:project_management_app/app/core/utils/format_date.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';

class ProjectViewerScreen extends StatelessWidget {
  final Project project;
  const ProjectViewerScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20,),
                Text('By ${project.posterName}', style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                  ),
                ),
                const SizedBox(height: 5,),
                Text('${formatrdateBydMMMYYY(project.updatedAt)} . ${calculateReadingTime(project.content)} min',
                style: const TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(project.imageUrl, fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(project.content, style: const TextStyle(
                  fontSize: 16,
                  height: 2
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}