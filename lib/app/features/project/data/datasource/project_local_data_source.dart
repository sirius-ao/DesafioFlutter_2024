import 'package:hive/hive.dart';
import 'package:project_management_app/app/features/project/data/models/project_model.dart';

abstract interface class IProjectLocalDataSource{
  void uploadLocalProjects({ required List<ProjectModel> projects});
  List<ProjectModel> loadProjects();
}

class ProjectLocalDataSourceImpl implements IProjectLocalDataSource{
  final Box box;
  ProjectLocalDataSourceImpl(this.box);
  
  @override
  List<ProjectModel> loadProjects() {
    List<ProjectModel> projects = [];
    for (var i = 0; i < box.length; i++) {
      projects.add(ProjectModel.formJson(box.get(i.toString())));
    }
    return projects;
  }

  @override
  void uploadLocalProjects({required List<ProjectModel> projects}) {
    box.clear();
    for (var i = 0; i < projects.length; i++) {
      box.put(i.toString(), projects[i].toJson());
    }
  }

}