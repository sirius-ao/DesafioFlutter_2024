import 'package:flutter/material.dart';
import 'package:project_management_app/app/core/utils/calculate_reading_time.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';
import 'package:project_management_app/app/features/project/presentation/screens/project_viewer_screen.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final Color color;
  const ProjectCard({
    super.key, 
    required this.project, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProjectViewerScreen(
            project: project 
            ),
          ),
       );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: 
                      project.topics
                    .map((e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(
                        label: Text(e),
                        ),
                    )
                    ).toList(),
                  ),
                ),
                Text(
                  project.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                ),
              ],
            ),
            Text('${calculateReadingTime(project.content)} min')
          ],
        ),
      ),
    );
  }
}