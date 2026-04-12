import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Profile System"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileAiLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Fetching data from API..."),
                ],
              );
            }

            else if (state is ProfileAiSuccess) {
              final user = state.userProfile;

              return SingleChildScrollView( // عشان نضمن إن الداتا لو كتير متعملش Overflow
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. عرض الصورة الديناميكية مع معالجة الأخطاء
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      backgroundImage: NetworkImage(user.userImage),
                      onBackgroundImageError: (exception, stackTrace) {
                        // لو الرابط فيه مشكلة بيعرض أيكونة بدل ما يضرب
                      },
                    ),
                    const SizedBox(height: 20),

                    // 2. اسم المستخدم الحقيقي من الـ API
                    Text(
                      user.userName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Text(
                      "UI/UX Designer & Flutter Developer",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const Divider(height: 50, indent: 40, endIndent: 40),

                    // 3. كارت نصيحة الـ AI
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.withOpacity(0.05), Colors.blue.withOpacity(0.15)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
                                SizedBox(width: 8),
                                Text("AI STRATEGY", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              user.advice,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // زرار التحديث اللي بينادي الـ Prompt الديناميكي
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () => context.read<ProfileCubit>().getAiAdvice(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text("Refresh Dynamic Data"),
                    ),
                  ],
                ),
              );
            }

            else if (state is ProfileAiError) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, color: Colors.red, size: 60),
                    const SizedBox(height: 10),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileCubit>().getAiAdvice(),
                      child: const Text("Retry Connection"),
                    )
                  ],
                ),
              );
            }

            // الحالة الابتدائية: أول ما نفتح الصفحة
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.read<ProfileCubit>().getAiAdvice(),
                  child: const Text("Connect to AI API"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}