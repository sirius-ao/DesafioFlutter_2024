import 'dart:io';
import 'package:project_management_app/app/core/failures/exceptions/server_exception.dart';
import 'package:project_management_app/app/features/project/data/models/project_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IProjectRemoteDataSource{
  Future<ProjectModel> uploadProject(ProjectModel project);
   Future<String> uploadProjectImage({
    required File image,
    required ProjectModel project,
   });
   Future<List<ProjectModel>> getAllProjects();
}
class ProjectSupaBaseRemoteDataSourceImpl implements IProjectRemoteDataSource{
  final SupabaseClient supabaseClient;
  ProjectSupaBaseRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<ProjectModel> uploadProject(ProjectModel project) async{
    try {
      final projectsData = await supabaseClient.from('projects').insert(project.toJson()).select();
      return ProjectModel.formJson(projectsData.first);
    } catch (e) {
      throw ServerException( e.toString());
    }
  }
  
  @override
  Future<String> uploadProjectImage({required File image, required ProjectModel project}) async {
    try {
      await supabaseClient.storage.from('project_images').upload(
        project.id,
        image
      );
      return supabaseClient.storage.from('project_images').getPublicUrl(project.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      final projects = await supabaseClient.from('projects').select('*, profiles (name)');
      return projects.map((project) => ProjectModel.formJson(project).copyWith(posterName: project['profiles']['name'])).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

}