import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';

abstract interface class IProjectRepository{
  Future<Either<Failure, Project>> uploadProject({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, List<Project>>> getAllProjects();
}