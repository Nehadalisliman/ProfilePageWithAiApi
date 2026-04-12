import 'dart:convert';
import 'package:http/http.dart' as http;

class OllamaService {
  // للـ Web يفضل استخدام 127.0.0.1 لضمان استقرار الاتصال
  static const String _baseUrl = 'http://127.0.0.1:11434/api/generate';
  Future<Map<String, dynamic>> fetchAiResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          // أحياناً المتصفح يحتاج تحديد نوع الاستجابة المتوقعة
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "model": "llama3",
          "prompt": prompt,
          "stream": false,
          "format": "json", // يضمن أن الرد سيكون JSON صالح فقط
        }),
      );

      if (response.statusCode == 200) {
        // 1. فك JSON الخاص بـ Ollama نفسه
        final Map<String, dynamic> outerData = jsonDecode(response.body);

        // 2. استخراج محتوى الرد (response)
        final String rawContent = outerData['response'] ?? "";

        if (rawContent.isEmpty) {
          throw Exception("Ollama returned an empty response");
        }

        // 3. فك محتوى الرد لتحويله لـ Map (الاسم، الصورة، النصيحة)
        return jsonDecode(rawContent) as Map<String, dynamic>;
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      // طباعة التفاصيل في الـ Debug Console لسهولة الإصلاح
      print("--- Ollama Debug Start ---");
      print("Error Detail: $e");
      print("--- Ollama Debug End ---");

      // نرسل رسالة واضحة للـ Cubit
      throw Exception("خطأ في الاتصال: تأكدي أن Ollama يعمل بالأمر الخاص بالـ CORS");
    }
  }
}