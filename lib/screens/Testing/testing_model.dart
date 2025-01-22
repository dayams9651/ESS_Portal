class LeaveBalanceModel {
  final bool success;
  final LeaveData data;

  LeaveBalanceModel({required this.success, required this.data});

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      success: json['success'],
      data: LeaveData.fromJson(json['data']),
    );
  }
}

class LeaveData {
  final double totalYrBal;
  final double lOpBal;
  final double lClBal;

  LeaveData({required this.totalYrBal, required this.lOpBal, required this.lClBal});

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
      totalYrBal: json['total_yr_bal'].toDouble(),
      lOpBal: json['l_op_bal'].toDouble(),
      lClBal: json['l_cl_bal'].toDouble(),
    );
  }
}
