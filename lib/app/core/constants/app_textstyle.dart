import 'package:flutter/material.dart';
import 'package:project_management_app/app/core/constants/app_colors.dart';

class AppTextStyle{
  AppTextStyle._();
  static const TextStyle titleStyle1 = TextStyle(
    color: AppColor.whiteColor,
     fontSize: 24,
     fontWeight: FontWeight.bold
  );
  static const TextStyle hintTextStyle1 = TextStyle(
    color: AppColor.greyColor,
     fontSize: 12,
     fontWeight: FontWeight.normal
  );
}