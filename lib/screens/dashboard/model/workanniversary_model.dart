class WorkAnniversaryModel {
  int? code;
  String? status;
  List<Data>? data;

  WorkAnniversaryModel({this.code, this.status, this.data});

  WorkAnniversaryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
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
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? type;
  String? date;
  String? day;
  String? department;
  String? photo;
  String? subDepartment;

  Data(
      {this.name,
        this.type,
        this.date,
        this.day,
        this.department,
        this.photo,
        this.subDepartment});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    date = json['date'];
    day = json['day'];
    department = json['department'];
    photo = json['photo'];
    subDepartment = json['sub_department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['date'] = this.date;
    data['day'] = this.day;
    data['department'] = this.department;
    data['photo'] = this.photo;
    data['sub_department'] = this.subDepartment;
    return data;
  }
}
