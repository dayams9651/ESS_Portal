class AttendanceModel {
  int? code;
  Result? result;

  AttendanceModel({this.code, this.result});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Data>? data;
  int? totalPresent;
  int? totalMisspunch;

  Result({this.data, this.totalPresent, this.totalMisspunch});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalPresent = json['total_present'];
    totalMisspunch = json['total_misspunch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_present'] = this.totalPresent;
    data['total_misspunch'] = this.totalMisspunch;
    return data;
  }
}

class Data {
  String? title;
  String? start;
  String? totalTime;

  Data({this.title, this.start, this.totalTime});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    start = json['start'];
    totalTime = json['total_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['start'] = this.start;
    data['total_time'] = this.totalTime;
    return data;
  }
}
