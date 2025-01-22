// New wHire List Model

class NewHireListModel {
  bool? success;
  String? status;
  List<Data>? data;

  NewHireListModel({this.success, this.status, this.data});

  NewHireListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? date;
  String? day;
  String? timeago;
  String? department;
  String? photo;
  String? subDepartment;

  Data(
      {this.name,
        this.date,
        this.day,
        this.timeago,
        this.department,
        this.photo,
        this.subDepartment});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    day = json['day'];
    timeago = json['timeago'];
    department = json['department'];
    photo = json['photo'];
    subDepartment = json['sub_department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['day'] = this.day;
    data['timeago'] = this.timeago;
    data['department'] = this.department;
    data['photo'] = this.photo;
    data['sub_department'] = this.subDepartment;
    return data;
  }
}
