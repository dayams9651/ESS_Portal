class LeaveStatusModel {
  final String ?leavetype;
  final String ?fromdt;
  final String ?todt;
  final String? totalday;
  final String ?trackid;
  final String ?status;
  final String ?regdate;
  final String ?regago;
  final String? reportto;
  final String ?code;
  final String ?remark;

  LeaveStatusModel({
    this.leavetype,
     this.fromdt,
     this.todt,
     this.totalday,
     this.trackid,
     this.status,
     this.regdate,
     this.regago,
     this.reportto,
     this.code,
     this.remark,
  });
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
      remark: json['remark'],
    );
  }
}