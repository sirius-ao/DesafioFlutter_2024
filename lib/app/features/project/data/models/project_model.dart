import 'package:project_management_app/app/features/project/domain/entities/project.dart';

class ProjectModel extends Project{
  ProjectModel({
    required super.id, 
    required super.posterId, 
    required super.title, 
    required super.content, 
    required super.imageUrl, 
    required super.topics, 
    required super.updatedAt,
    super.posterName
  });
  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String()
    };
  }
  factory ProjectModel.formJson(Map<String, dynamic> map){
    return ProjectModel(
      id: map['id'], 
      posterId: map['poster_id'], 
      title: map['title'], 
      content: map['content'], 
      imageUrl: map['image_url'], 
      topics: List<String>.from(map['topics'] ?? []), 
      updatedAt: map['updated_at'] == null? 
        DateTime.now():
        DateTime.parse(map['updated_at'])
    );
  }
   ProjectModel copyWith({
    final String? id,
    final String? posterId,
    final String? title,
    final String ?content,
    final String? imageUrl,
    final List<String>? topics,
    final DateTime? updatedAt,
    final String? posterName,
   }){
   return ProjectModel(
      id : id ?? this.id, 
      posterId : posterId ?? this.posterId, 
      title : title ?? this.title, 
      content : content ?? this.content, 
      imageUrl : imageUrl ?? this.imageUrl,
      topics : topics ?? this.topics, 
      updatedAt : updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName
    );
  }
}