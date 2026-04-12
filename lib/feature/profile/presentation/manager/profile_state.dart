
import '../../domain/entites/profile_ai_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileAiLoading extends ProfileState {}

class ProfileAiSuccess extends ProfileState {
  // بدل ما بنشيل String نصيحة بس، بنشيل الـ Entity كامل
  final ProfileAiEntity userProfile;

  ProfileAiSuccess(this.userProfile);
}

class ProfileAiError extends ProfileState {
  final String message;
  ProfileAiError(this.message);
}