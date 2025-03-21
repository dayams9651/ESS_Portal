class LeaveStatusModel {
  final String leavetype;
  final String fromdt;
  final String todt;
  final String totalday;
  final String trackid;
  final String status;
  final String regdate;
  final String regago;
  final String reportto;
  final String code;

  LeaveStatusModel({
    required this.leavetype,
    required this.fromdt,
    required this.todt,
    required this.totalday,
    required this.trackid,
    required this.status,
    required this.regdate,
    required this.regago,
    required this.reportto,
    required this.code,
  });

  // Factory constructor to create a LeaveRequest from a map (JSON)
  factory LeaveStatusModel.fromJson(Map<String, dynamic> json) {
    return LeaveStatusModel(
      leavetype: json['leavetype'],
      fromdt: json['fromdt'],
      todt: json['todt'],
      totalday: json['totalday'],
      trackid: json['trackid'],
      status: json['status'],
      regdate: json['regdate'],
      regago: json['regago'],
      reportto: json['reportto'],
      code: json['code'],
    );
  }
}