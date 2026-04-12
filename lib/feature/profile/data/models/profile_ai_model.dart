import '../../domain/entites/profile_ai_entity.dart';

class ProfileAiModel extends ProfileAiEntity {
  ProfileAiModel({
    required super.advice,
    required super.userName,
    required super.userImage,
  });

  factory ProfileAiModel.fromJson(Map<String, dynamic> json) {
    // 1. استخراج النصيحة (Advice)
    // بنجرب أكتر من مفتاح متوقع من الـ AI
    final String extractedAdvice = json['response'] ?? json['advice'] ?? 'No advice received';

    // 2. استخراج بيانات المستخدم (User Data)
    // بنفككها بشكل آمن عشان لو حقل 'user' مش موجود التطبيق ميعملش Crash
    final Map<String, dynamic>? userData = json['user'];

    return ProfileAiModel(
      advice: extractedAdvice,
      // لو الـ API بعت اسم هنعرضه، لو مبعتش هنكتب "User" (داتا ديناميك احتياطية)
      userName: userData?['name'] ?? json['userName'] ?? 'User',
      // رابط الصورة الديناميكي
      userImage: userData?['image_url'] ?? json['userImage'] ?? 'https://via.placeholder.com/150',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'response': advice,
      'user': {
        'name': userName,
        'image_url': userImage,
      },
    };
  }
}