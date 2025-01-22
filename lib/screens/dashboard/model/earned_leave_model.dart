class LeaveBalanceModel {
  bool? success;
  Data? data;

  LeaveBalanceModel({this.success, this.data});

  LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalYrBal;
  String? lOpBal;
  String? lClBal;

  Data({this.totalYrBal, this.lOpBal, this.lClBal});

  Data.fromJson(Map<String, dynamic> json) {
    totalYrBal = json['total_yr_bal'];
    lOpBal = json['l_op_bal'];
    lClBal = json['l_cl_bal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_yr_bal'] = totalYrBal;
    data['l_op_bal'] = lOpBal;
    data['l_cl_bal'] = lClBal;
    return data;
  }
}
