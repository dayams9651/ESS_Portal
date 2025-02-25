class LoginResponse {
  bool? success;
  String? message;
  Data? data;

  LoginResponse({this.success, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? userName;
  String? photo;
  String? userID;
  String? designation;

  Data({this.token, this.userName, this.photo, this.userID, this.designation});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
    photo = json['photo'];
    userID = json['userID'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userName'] = this.userName;
    data['photo'] = this.photo;
    data['userID'] = this.userID;
    data['designation'] = this.designation;
    return data;
  }
}
