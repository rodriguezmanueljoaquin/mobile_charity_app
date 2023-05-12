class VolunteeringModel {
  final String id;
  final String title;
  final String description;

  const VolunteeringModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) {
    return VolunteeringModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
