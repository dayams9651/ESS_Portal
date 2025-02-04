class Employee {
  final String id;
  final String name;
  final String title;
  final String empcode;
  final String imageUrl;
  final List<Employee> children;

  Employee({
    required this.id,
    required this.name,
    required this.title,
    required this.empcode,
    required this.imageUrl,
    required this.children,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      empcode: json['empcode'] ?? '',
      imageUrl: json['imageUrl'],
      children: json['children'] != null
          ? List<Employee>.from(
          json['children'].map((x) => Employee.fromJson(x)))
          : [],
    );
  }
}