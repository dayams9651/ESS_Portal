//
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import '../const/api_urls.dart';
// import '../screens/auth/save_auth_data.dart';
// import '../utils/const_toast.dart';
// class ApiService {
//   static final Dio _dio = Dio();
//   static void init() {
//     _dio.options.baseUrl = baseUrl;
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           bool isPublicToken = options.extra['publicToken'] ?? false;
//           if (isPublicToken) {
//             options.headers['Authorization'] = "Token 52fca82c967fc97df119f49faab7b9179e73f229";
//           } else {
//             options.headers['Authorization'] = 'Token ${await UserDataService.getAuthToken()}';
//           }
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           return handler.next(response);
//         },
//         onError: (e, handler) {
//           if (e.response != null) {
//             if (e.response?.data["message"] is List) {
//               ConstToast.to.showSuccess("${e.response?.data["message"][0]}");
//             } else {
//               ConstToast.to.showError("${e.response?.data["message"]}");
//             }
//             debugPrint('Error status: ${e.response!.statusCode}');
//             debugPrint('Error message: ${e.response!.statusMessage}');
//             debugPrint('Error data: ${e.response!.data}');
//           } else {
//             debugPrint('Dio Error: $e');
//           }
//           return handler.next(e);
//         },
//       ),
//     );
//
//     // if (kDebugMode) {
//     //   _dio.interceptors.add(PrettyDioLogger(
//     //     requestBody: true,
//     //   ));
//     // }
//   }
//
//   static Future<Response> getData(String path,
//       {Map<String, dynamic>? queryParameters, dynamic data}) async {
//     try {
//       final response = await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         data: data,
//       );
//       return response;
//     } catch (e) {
//       throw 'Failed to fetch data: $e';
//     }
//   }
//
//   static Future<Response> postData(
//       {required String url, dynamic data, Options? options, bool publicToken = false}) async {
//     try {
//       options ??= Options();
//       options.extra ??= {};
//       options.extra?['publicToken'] = publicToken;
//
//       final response = await _dio.post(
//         url,
//         data: data,
//         options: options,
//       );
//
//       return response;
//     } catch (e) {
//       throw 'Failed to post data: $e';
//     }
//   }
//
//   static Future<Response> uploadImage({
//     required String url,
//     required File imageFile,
//     Map<String, dynamic>? additionalData,
//   }) async {
//     try {
//       FormData formData = FormData.fromMap({
//         "image": await MultipartFile.fromFile(imageFile.path,
//             filename: imageFile.path.split('/').last),
//         if (additionalData != null) ...additionalData,
//       });
//
//       final response = await _dio.post(
//         url,
//         data: formData,
//       );
//
//       return response;
//     } catch (e) {
//       throw 'Failed to upload image: $e';
//     }
//   }
//
//   static Future<Response> uploadImages({
//     required String url,
//     required FormData formData,
//   }) async {
//     try {
//       final response = await _dio.post(
//         url,
//         data: formData,
//       );
//       return response;
//     } catch (e) {
//       throw 'Failed to upload image: $e';
//     }
//   }
//
//   static Future<Response> uploadPatchImages({
//     required String url,
//     required FormData formData,
//   }) async {
//     try {
//       final response = await _dio.patch(
//         url,
//         data: formData,
//       );
//       return response;
//     } catch (e) {
//       throw 'Failed to upload image: $e';
//     }
//   }
//   // New PUT method
//   static Future<Response> putData(
//       {required String url, dynamic data, Options? options, bool publicToken = false}) async {
//     try {
//       options ??= Options();
//       options.extra ??= {};
//       options.extra?['publicToken'] = publicToken;
//
//       final response = await _dio.put(
//         url,
//         data: data,
//         options: options,
//       );
//
//       return response;
//     } catch (e) {
//       throw 'Failed to update data: $e';
//     }
//   }
//
//   // New PATCH method
//   static Future<Response> patchData(
//       {required String url, dynamic data, Options? options, bool publicToken = false}) async {
//     try {
//       options ??= Options();
//       options.extra ??= {};
//       options.extra?['publicToken'] = publicToken;
//
//       final response = await _dio.patch(
//         url,
//         data: data,
//         options: options,
//       );
//
//       return response;
//     } catch (e) {
//       throw 'Failed to patch data: $e';
//     }
//   }
//
//   // New DELETE method
//   static Future<Response> deleteData(
//       {required String url, dynamic data, Options? options, bool publicToken = false}) async {
//     try {
//       options ??= Options();
//       options.extra ??= {};
//       options.extra?['publicToken'] = publicToken;
//
//       final response = await _dio.delete(
//         url,
//         data: data,
//         options: options,
//       );
//
//       return response;
//     } catch (e) {
//       throw 'Failed to delete data: $e';
//     }
//   }
//
// }
//
