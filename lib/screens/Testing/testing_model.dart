class AttendanceStatistics {
  final bool success;
  final String status;
  final List<AttendanceData> data;
  final List<String> months;

  AttendanceStatistics({
    required this.success,
    required this.status,
    required this.data,
    required this.months,
  });

  factory AttendanceStatistics.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<AttendanceData> dataList = list.map((i) => AttendanceData.fromJson(i)).toList();

    return AttendanceStatistics(
      success: json['success'],
      status: json['status'],
      data: dataList,
      months: List<String>.from(json['months']),
    );
  }
}

class AttendanceData {
  final String name;
  final List<int> data;

  AttendanceData({
    required this.name,
    required this.data,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      name: json['name'],
      data: List<int>.from(json['data']),
    );
  }
}
