
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
}

class Data {
 final String token;
 final String userId;
 final String userName;
 final String designation;
 final String photo;

  Data({
    required this.token,
    required this.userId,
    required this.userName,
    required this.designation,
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
}
