class NotesModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<String> tags;

  NotesModel({
    required this.tags,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.id,
  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      tags: List<String>.from(map['tags']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }



 Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'tags': tags,
    };
 }
}
