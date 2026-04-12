
import '../../domain/repos/profile_repository.dart';
import '../datasources/ollama_service.dart';
import '../models/profile_ai_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final OllamaService ollamaService;

  ProfileRepositoryImpl(this.ollamaService);

  @override
  Future<ProfileAiModel> getAiAdvice(String prompt) async {
    // 1. بنجيب الـ JSON (Map) بالكامل من الـ Service
    // هنا بنفترض إن fetchAiResponse اتعدلت وبقت بترجع Map<String, dynamic>
    final jsonData = await ollamaService.fetchAiResponse(prompt);

    // 2. بنستخدم الـ fromJson اللي عملناه في الموديل عشان يفكك كل حاجة
    // الاسم، الصورة، والنصيحة.. كله هييجي من الـ JSON ده
    return ProfileAiModel.fromJson(jsonData);
  }
}