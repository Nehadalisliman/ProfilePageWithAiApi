import 'dart:convert';
import 'package:prfilepage/core/network/api_client.dart'; // تأكد من المسار الصحيح

class OllamaService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> fetchAiResponse(String prompt) async {
    try {
      final response = await _apiClient.postData('generate', {
        "model": "llama3",
        "prompt": prompt,
        "stream": false,
        "format": "json",
      });

      if (response.statusCode == 200) {
        // Dio يقوم بعمل jsonDecode تلقائياً، لذا نستخدم response.data مباشرة
        final Map<String, dynamic> outerData = response.data;
        final String rawContent = outerData['response'] ?? "";

        if (rawContent.isEmpty) throw Exception("Empty response");

        return jsonDecode(rawContent) as Map<String, dynamic>;
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Ollama Error: $e");
      throw Exception("تأكد أن Ollama يعمل ومفعل فيه خاصية الـ CORS");
    }
  }
}