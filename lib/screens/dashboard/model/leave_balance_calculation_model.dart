class LeaveBalanceCalculationModel {
  int? code;
  Data? data;

  LeaveBalanceCalculationModel({this.code, this.data});

  LeaveBalanceCalculationModel.fromJson(Map<String, dynamic> json) {
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
  double? currentBooking;

  Data({this.currentBooking});

  Data.fromJson(Map<String, dynamic> json) {
    currentBooking = json['currentBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentBooking'] = this.currentBooking;
    return data;
  }
}
