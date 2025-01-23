// // lib/models/leave_balance_model.dart
// class LeaveBalanceModel1 {
//   final bool success;
//   final Data data;
//
//   LeaveBalanceModel1({required this.success, required this.data});
//
//   factory LeaveBalanceModel1.fromJson(Map<String, dynamic> json) {
//     return LeaveBalanceModel1(
//       success: json['success'],
//       data: Data.fromJson(json['data']),
//     );
//   }
// }
//
// class Data {
//   final int totalYrBal;
//   final String lOpBal;
//   final String lClBal;
//
//   Data({required this.totalYrBal, required this.lOpBal, required this.lClBal});
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       totalYrBal: json['total_yr_bal'],
//       lOpBal: json['l_op_bal'],
//       lClBal: json['l_cl_bal'],
//     );
//   }
// }
