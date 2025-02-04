
class LeaveBalanceModel {
  final bool? success;
  final Data? data;

  LeaveBalanceModel({this.success, this.data});

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
        success : json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int? totalYrBal;
  final String? lOpBal;
  final String? lClBal;

  Data({this.totalYrBal, this.lOpBal, this.lClBal});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        totalYrBal : json['total_yr_bal'],
        lOpBal : json['l_op_bal'],
        lClBal : json['l_cl_bal'],
    );
  }
}
