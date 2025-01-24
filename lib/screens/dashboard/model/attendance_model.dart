
class Attendance {
  final String title;
  final String start;
  final String totalTime;

  Attendance({required this.title, required this.start, required this.totalTime});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      title: json['title'],
      start: json['start'],
      totalTime: json['total_time'] ?? '',
    );
  }
}

class AttendanceResponse {
  final List<Attendance> data;
  final int totalPresent;
  final int totalMissPunch;

  AttendanceResponse({required this.data, required this.totalPresent, required this.totalMissPunch});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result']['data'] as List;
    List<Attendance> attendanceList = list.map((e) => Attendance.fromJson(e)).toList();
    return AttendanceResponse(
      data: attendanceList,
      totalPresent: json['result']['total_present'],
      totalMissPunch: json['result']['total_misspunch'],
    );
  }
}
