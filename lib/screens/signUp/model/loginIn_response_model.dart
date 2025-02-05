class LoginResponse {
  String status;
  String message;
  bool success;
  Data data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.success,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'success': success,
      'data': data.toJson(),
    };
  }
}

class Data {
  String token;
  String userId;
  String userName;
  String? designation;
  String photo;

  Data({
    required this.token,
    required this.userId,
    required this.userName,
    this.designation,
    required this.photo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      userId: json['userId'],
      userName: json['userName'],
      designation: json['designation'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'userName': userName,
      'designation': designation,
      'photo': photo,
    };
  }
}
