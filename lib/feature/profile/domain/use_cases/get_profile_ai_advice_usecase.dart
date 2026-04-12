
import '../entites/profile_ai_entity.dart';
import '../repos/profile_repository.dart';

class GetProfileAiAdviceUseCase {
  final ProfileRepository repository;

  GetProfileAiAdviceUseCase(this.repository);

  Future<ProfileAiEntity> call(String prompt) {
    return repository.getAiAdvice(prompt);
  }
}