import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppTextStyles {
  // استخدام .sp لضمان استجابة الخطوط لأحجام الشاشات المختلفة
  static TextStyle font32Bold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static TextStyle font16Grey = TextStyle(
    fontSize: 16.sp,
    color: AppColors.textGrey,
  );

  static TextStyle font14BlueGrey = TextStyle(
    fontSize: 14.sp,
    color: Colors.blueGrey,
  );

  static TextStyle font14OrangeBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle font18WhiteBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}