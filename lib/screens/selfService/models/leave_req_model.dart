// models/leave_request.dart
class LeaveGrantModel {
  final String leavetype;
  final String totalday;
  final String trackid;
  final String status;
  final String regdate;
  final String regago;
  final String empcode;
  final String empname;
  final String department;
  final String designation;
  final String photo;
  final String remark;

  LeaveGrantModel({
    required this.leavetype,
    required this.totalday,
    required this.trackid,
    required this.status,
    required this.regdate,
    required this.regago,
    required this.empcode,
    required this.empname,
    required this.department,
    required this.designation,
    required this.photo,
    required this.remark,
  });

  factory LeaveGrantModel.fromJson(Map<String, dynamic> json) {
    return LeaveGrantModel(
      leavetype: json['leavetype'],
      totalday: json['totalday'],
      trackid: json['trackid'],
      status: json['status'],
      regdate: json['regdate'],
      regago: json['regago'],
      empcode: json['empcode'],
      empname: json['empname'],
      department: json['department'],
      designation: json['designation'],
      photo: json['photo'],
      remark: json['remark'],
    );
  }
}

