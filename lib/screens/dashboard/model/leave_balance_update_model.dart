class LeaveUpdateModel {
  int? code;
  Data? data;

  LeaveUpdateModel({this.code, this.data});

  LeaveUpdateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? totalYrBal;
  String? lClBal;

  Data({this.totalYrBal, this.lClBal});

  Data.fromJson(Map<String, dynamic> json) {
    totalYrBal = json['total_yr_bal'];
    lClBal = json['l_cl_bal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_yr_bal'] = this.totalYrBal;
    data['l_cl_bal'] = this.lClBal;
    return data;
  }
}
