class SickLeaveModel {
  int? code;
  Data? data;
  String? compBal;

  SickLeaveModel({this.code, this.data, this.compBal});

  SickLeaveModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    compBal = json['compBal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['compBal'] = this.compBal;
    return data;
  }
}

class Data {
  String? totalYrBal;
  String? lOpBal;
  String? lClBal;

  Data({this.totalYrBal, this.lOpBal, this.lClBal});

  Data.fromJson(Map<String, dynamic> json) {
    totalYrBal = json['total_yr_bal'];
    lOpBal = json['l_op_bal'];
    lClBal = json['l_cl_bal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_yr_bal'] = this.totalYrBal;
    data['l_op_bal'] = this.lOpBal;
    data['l_cl_bal'] = this.lClBal;
    return data;
  }
}
