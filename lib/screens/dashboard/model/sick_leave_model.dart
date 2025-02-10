
class SickLeaveModel {
  final bool success;
  final Data data;

  SickLeaveModel({required this.success, required this.data});

  factory SickLeaveModel.fromJson(Map<String, dynamic> json) {
    return SickLeaveModel(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final double totalYrBal;
  final String lOpBal;
  final String lClBal;

  Data({required this.totalYrBal, required this.lOpBal, required this.lClBal});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      totalYrBal: json['total_yr_bal'].toDouble(),
      lOpBal: json['l_op_bal'],
      lClBal: json['l_cl_bal'],
    );
  }
}