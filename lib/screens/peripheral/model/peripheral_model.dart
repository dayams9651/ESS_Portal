class AssetModel {
  final String name;
  final String model;
  final String serial;
  final String category;
  final String description;
  final String identity;
  final String status;
  final String allotedDt;
  final List<String> images;

  AssetModel({
    required this.name,
    required this.model,
    required this.serial,
    required this.category,
    required this.description,
    required this.identity,
    required this.status,
    required this.allotedDt,
    required this.images,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      name: json['name'],
      model: json['model'],
      serial: json['serial'],
      category: json['catergory'],
      description: json['description'],
      identity: json['identity'],
      status: json['status'],
      allotedDt: json['alloted_dt'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
