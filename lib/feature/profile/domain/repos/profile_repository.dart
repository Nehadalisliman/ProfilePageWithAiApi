
import '../entites/profile_ai_entity.dart';

abstract class ProfileRepository {
  Future<ProfileAiEntity> getAiAdvice(String prompt);
}