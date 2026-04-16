
import 'package:dio/dio.dart';

class ApiClient {
  // تعريف كائن Dio
  final Dio _dio = Dio(
    BaseOptions(
      // ملاحظة: الرابط الذي تستخدمه يبدو خاصاً بـ Ollama (الذكاء الاصطناعي المحلي)
      baseUrl: 'http://127.0.0.1:11434/api/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // دالة لجلب البيانات (GET Request)
  Future<Response> getData(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      // معالجة الخطأ بشكل أفضل
      throw _handleError(e);
    }
  }

  // دالة لإرسال البيانات (POST Request) - مفيدة جداً لتعامل مع نماذج الذكاء الاصطناعي
  Future<Response> postData(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // دالة داخلية لتنظيم رسائل الخطأ
  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection Timeout";
    }
    return e.message ?? "Unknown Error";
  }
}