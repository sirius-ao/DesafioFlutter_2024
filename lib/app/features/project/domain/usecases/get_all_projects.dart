import 'package:fpdart/fpdart.dart';
import 'package:project_management_app/app/core/failures/failure.dart';
import 'package:project_management_app/app/core/usecases/usecase.dart';
import 'package:project_management_app/app/features/auth/domain/usecases/current_user.dart';
import 'package:project_management_app/app/features/project/domain/entities/project.dart';
import 'package:project_management_app/app/features/project/domain/repositories/project_repository.dart';

class GetAllProjects implements UseCase<List<Project>, NoParams>{
  final IProjectRepository blogRepository;
  GetAllProjects(this.blogRepository);
  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) async{
    return await blogRepository.getAllProjects();
  }
}