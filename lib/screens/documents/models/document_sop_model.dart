
class SOPModel {
  final String key;
  final String name;
  final String path;
  final String description;
  final String datetime;
  final String fileType;
  final String fileSize;

  SOPModel({
    required this.key,
    required this.name,
    required this.path,
    required this.description,
    required this.datetime,
    required this.fileType,
    required this.fileSize,
  });

  factory SOPModel.fromJson(Map<String, dynamic> json) {
    return SOPModel(
      key: json['key'],
      name: json['name'],
      path: json['path'],
      description: json['description'],
      datetime: json['datetime'],
      fileType: json['file_type'],
      fileSize: json['file_size'],
    );
  }
}
