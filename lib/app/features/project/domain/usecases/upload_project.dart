import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/usecases/usecase.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';
import 'package:project_management_app/app/features/project/domain/repositories/project_repository.dart';

class UploadProject implements UseCase<Project, UploadProjectParams>{
  final IProjectRepository blogRepository;
  UploadProject({required this.blogRepository});
  
  @override
  Future<Either<Failure, Project>> call(UploadProjectParams params) async {
   return await blogRepository.uploadProject(
      image: params.image, 
      title: params.title, 
      content: params.content, 
      posterId: params.posterId, 
      topics: params.topics
    );
  }
  
}

class UploadProjectParams{
    final File image; 
    final String title; 
    final String content; 
    final String posterId; 
    final List<String> topics;

  UploadProjectParams({
    required this.image, 
    required this.title, 
    required this.content, 
    required this.posterId, 
    required this.topics
  });
}