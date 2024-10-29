part of 'project_bloc.dart';
@immutable
sealed class ProjectEvent{}
final class ProjectUpLoadEvent extends ProjectEvent{
  final File image; 
  final String title; 
  final String content; 
  final String posterId; 
  final List<String> topics;

  ProjectUpLoadEvent({
    required this.image, 
    required this.title, 
    required this.content, 
    required this.posterId, 
    required this.topics
  });
}

final class ProjectGetAllEvent extends ProjectEvent {}