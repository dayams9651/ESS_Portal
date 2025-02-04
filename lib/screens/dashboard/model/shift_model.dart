import 'dart:convert';

class ShiftModel {
  final String shift;
  final String startTime;
  final String endTime;
  final String division;
  final String todayIn;
  final String totalHour;

  ShiftModel({
    required this.shift,
    required this.startTime,
    required this.endTime,
    required this.division,
    required this.todayIn,
    required this.totalHour,
  });

  // Factory method to create a ShiftModel from JSON
  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      shift: json['shift'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      division: json['division'],
      todayIn: json['today_in'],
      totalHour: json['total_hour'],
    );
  }

  // Method to convert a ShiftModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'shift': shift,
      'start_time': startTime,
      'end_time': endTime,
      'division': division,
      'today_in': todayIn,
      'total_hour': totalHour,
    };
  }
}
