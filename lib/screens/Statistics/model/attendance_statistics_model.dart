class AttendanceData {
  final String name;
  final List<int> data;

  AttendanceData({required this.name, required this.data});

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      name: json['name'],
      data: List<int>.from(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': data,
    };
  }
}

class AttendanceStatistics {
  final List<AttendanceData> data;
  final List<String> months;

  AttendanceStatistics({required this.data, required this.months});

  factory AttendanceStatistics.fromJson(Map<String, dynamic> json) {
    return AttendanceStatistics(
      data: (json['data'] as List)
          .map((item) => AttendanceData.fromJson(item))
          .toList(),
      months: List<String>.from(json['months']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'months': months,
    };
  }
}
