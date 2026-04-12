import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// استيراد الملفات الخاصة بمشروعك (تأكدي من صحة المسارات)
import 'feature/profile/data/datasources/ollama_service.dart';
import 'feature/profile/data/repositories/profile_repository_impl.dart';
import 'feature/profile/domain/use_cases/get_profile_ai_advice_usecase.dart';
import 'feature/profile/presentation/manager/profile_cubit.dart';
import 'feature/profile/presentation/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. تجهيز الـ Dependencies (التباعيات)
    // في المشاريع الكبيرة بنستخدم GetIt، بس هنا هنعملها يدوي للتبسيط
    final ollamaService = OllamaService();
    final profileRepository = ProfileRepositoryImpl(ollamaService);
    final getAiAdviceUseCase = GetProfileAiAdviceUseCase(profileRepository);

    return MultiBlocProvider(
      providers: [
        // 2. حقن الـ Cubit في التطبيق ليصبح متاحاً للشاشات
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(getAiAdviceUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Profile App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        // 3. الصفحة الرئيسية هي صفحة البروفايل اللي عملناها
        home: ProfileScreen(),
      ),
    );
  }
}