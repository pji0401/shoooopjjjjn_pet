class MissionGetResponse {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final int order;

  MissionGetResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.order,
  });

  factory MissionGetResponse.fromJson(Map<String, dynamic> json) {
    return MissionGetResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
      order: json['order'] as int,
    );
  }
}