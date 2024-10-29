import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/core/common/widgets/loader.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';
import 'package:project_management_app/app/core/enums/route_path.dart';
import 'package:project_management_app/app/core/utils/show_snackbar.dart';
import 'package:project_management_app/app/features/project/presentation/bloc/project_bloc.dart';
import 'package:project_management_app/app/features/project/presentation/widgets/project_card.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    context.read<ProjectBloc>().add(ProjectGetAllEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project App'),
        actions: [
          IconButton(
            onPressed: (){
              RoutePath.addProject.push(context);
            }, 
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener:(context, state) {
          if(state is ProjectFailureState){
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state){
          if (state is ProjectLoadingState) {
            return const Loader();
          }
          if (state is ProjectSuccessDisplayState) {
            return ListView.builder(
              itemCount: state.projects.length,
              itemBuilder: (context, index){
                final project = state.projects[index];
                return ProjectCard(
                  project: project,
                  color: index % 3 == 0 ?
                   AppColor.gradient1Color : index % 3 == 1 ?
                   AppColor.gradient2Color : AppColor.gradient3Color,
                  );
              }
            );
          }
          return const SizedBox();
        },
        ),
    );
  }
}