class HomeworkModel {
  int? id;
  String? name;
  String? description;
  String? date;
  String? type;
  String? color;

  HomeworkModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.type,
    this.color,
  });

  // Factory method to create an instance from a JSON map
  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      id: json['id'] ?? 0,
      name: json['Name'] ?? "",
      description: json['description'] ?? "",
      date: json['date'] ?? "",
      type: json['type'] ?? "",
      color: json['color'] ?? "",
    );
  }

  // Method to convert the model instance back to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['description'] = description;
    data['date'] = date;
    data['type'] = type;
    data['color'] = color;
    return data;
  }
}
