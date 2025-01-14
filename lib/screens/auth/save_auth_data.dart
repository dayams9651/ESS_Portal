// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserDataService {
//   static const token = 'token';
//   // static const userType = 'userType';
//
//   static Future<void> saveUserData(String authToken,) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(token, authToken);
//     // await prefs.setString(userType, userTypes);
//   }
//
//   static Future<String?> getAuthToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(token);
//   }
//
//   // static Future<String?> getUserType() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   return prefs.getString(userType);
//   // }
//
//
//
//   static Future<void> removeUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(
//       token,
//     );
//     // await prefs.remove(
//     //   userType,
//     // );
//   }
//
//   // static Future<void> saveUserType(userTypes) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString(userTypes);
//   // }
// }
