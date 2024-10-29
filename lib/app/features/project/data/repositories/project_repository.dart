import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/exceptions/server_exception.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/network/internet_connection/internet_checker_interface.dart';
import 'package:project_management_app/app/features/project/data/datasource/project_local_data_source.dart';
import 'package:project_management_app/app/features/project/data/datasource/project_remote_data_source.dart';
import 'package:project_management_app/app/features/project/data/models/project_model.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';
import 'package:project_management_app/app/features/project/domain/repositories/project_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepositoryImpl implements IProjectRepository{
  final IProjectRemoteDataSource projectRemoteDataSource;
  final IProjectLocalDataSource projectLocalDataSource;
  final IConnectionChecker connectionChecker;
  ProjectRepositoryImpl({
    required this.projectLocalDataSource, 
    required this.connectionChecker, 
    required this.projectRemoteDataSource
  });

  @override
  Future<Either<Failure, Project>> uploadProject({
    required File image, 
    required String title, 
    required String content, 
    required String posterId, 
    required List<String> topics
  }) async {
    try {
      if(!await (connectionChecker.isConnected)){
        return left(Failure('No internet connextion'));
      }
      ProjectModel projectModel = ProjectModel(
        id: const Uuid().v1(), 
        posterId: posterId, 
        title: title, 
        content: content, 
        imageUrl: '', 
        topics: topics, 
        updatedAt:  DateTime.now(),
      );
      final imageUrl  =  await projectRemoteDataSource.uploadProjectImage(
        image: image, 
        project: projectModel
      );
      projectModel = projectModel.copyWith(imageUrl: imageUrl);
      final uploadedProject =  await projectRemoteDataSource.uploadProject(projectModel);
      return right(uploadedProject);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Project>>> getAllProjects() async {
    try {
      if(!await (connectionChecker.isConnected)){
        final projects = projectLocalDataSource.loadProjects();
        return right(projects);
      }
      final projects = await projectRemoteDataSource.getAllProjects();
      projectLocalDataSource.uploadLocalProjects(projects: projects);
      return right(projects);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

}