import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_profile_ai_advice_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileAiAdviceUseCase getAiAdviceUseCase;

  ProfileCubit(this.getAiAdviceUseCase) : super(ProfileInitial());

  Future<void> getAiAdvice() async {
    emit(ProfileAiLoading());

    // الـ Prompt ده مكتوب بسطر واحد ومنسق عشان الـ AI ميتلخبطش في المسافات
    const String dynamicPrompt =
        'Return ONLY a JSON object: {"response": "Empower your designs with clean architecture and perfect UI/UX.", "user": {"name": "Nehad Sliman", "image_url": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"}}';

    try {
      final result = await getAiAdviceUseCase(dynamicPrompt);

      // لو الـ result رجع سليم، الشاشة هتعرض الاسم والصورة فوراً
      emit(ProfileAiSuccess(result));
    } catch (e) {
      // طباعة الخطأ في الـ Debug Console عشان لو حصلت مشكلة في الـ Parsing
      print("Cubit Error: $e");
      emit(ProfileAiError("عذراً، الـ API لم يرسل بيانات كاملة: $e"));
    }
  }
}