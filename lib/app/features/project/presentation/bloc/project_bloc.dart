import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_management_app/app/features/auth/domain/usecases/current_user.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';
import 'package:project_management_app/app/features/project/domain/usecases/get_all_projects.dart';
import 'package:project_management_app/app/features/project/domain/usecases/upload_project.dart';
part 'project_event.dart';
part 'project_state.dart';
class ProjectBloc extends Bloc<ProjectEvent, ProjectState>{
  final UploadProject _uploadProject;
  final GetAllProjects _getAllProjects;
  ProjectBloc({
    required UploadProject uploadProject, 
    required GetAllProjects getAllProjects
  }): _uploadProject = uploadProject,
   _getAllProjects = getAllProjects,
   super(ProjectInitialState()){
    on<ProjectEvent>((event, emit) => emit(ProjectLoadingState()));
    on<ProjectUpLoadEvent>(_onProjectUpload);
    on<ProjectGetAllEvent>(_onProjectGetAll);
  }
  void _onProjectUpload(
    ProjectUpLoadEvent event, 
    Emitter<ProjectState> emit
  ) async{
    final res = await _uploadProject(UploadProjectParams(
      image: event.image, 
      title: event.title, 
      content: event.content, 
      posterId: event.posterId, 
      topics: event.topics
      )
    );
    res.fold(
      (failure) => emit(ProjectFailureState(failure.message)),
      (project) => emit(ProjectUploadSuccessState(project))
    );
  }
  void _onProjectGetAll(
    ProjectGetAllEvent event, 
    Emitter<ProjectState> emit
  ) async{
    final res = await _getAllProjects(NoParams());
    res.fold(
      (failure) => emit(ProjectFailureState(failure.message)),
      (projects) => emit(ProjectSuccessDisplayState(projects))
    );
  }
}