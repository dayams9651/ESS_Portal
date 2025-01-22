class LeaveRequest {
  final String leaveType;
  final String dateFrom;
  final String dateTo;
  final String daysHrs;
  final String empCode;
  final String empName;
  final String empPhoto;
  final String willReturn;
  final String department;
  final String subDepartment;

  LeaveRequest({
    required this.leaveType,
    required this.dateFrom,
    required this.dateTo,
    required this.daysHrs,
    required this.empCode,
    required this.empName,
    required this.empPhoto,
    required this.willReturn,
    required this.department,
    required this.subDepartment,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      leaveType: json['leave_type'],
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      daysHrs: json['days_hrs'],
      empCode: json['emp_code'],
      empName: json['emp_name'],
      empPhoto: json['emp_photo'],
      willReturn: json['will_return'],
      department: json['department'],
      subDepartment: json['sub_department'],
    );
  }
}