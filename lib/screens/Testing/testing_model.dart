// model/user.dart
class User {
  final String token;
  final String userId;
  final String userName;
  final String designation;
  final String photo;

  User({
    required this.token,
    required this.userId,
    required this.userName,
    required this.designation,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['data']['token'],
      userId: json['data']['userId'],
      userName: json['data']['userName'],
      designation: json['data']['designation'],
      photo: json['data']['photo'],
    );
  }
}
