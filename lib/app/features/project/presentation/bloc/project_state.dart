part of 'project_bloc.dart';
@immutable
sealed class ProjectState{}
final class ProjectInitialState extends ProjectState{}

final class ProjectLoadingState extends ProjectState{}

final class ProjectUploadSuccessState extends ProjectState{
  final Project project;
  ProjectUploadSuccessState(this.project);
}
final class ProjectSuccessDisplayState extends ProjectState{
  final List<Project> projects;
  ProjectSuccessDisplayState(this.projects);
}

final class ProjectFailureState extends ProjectState{
  final String error;
  ProjectFailureState(this.error);
}