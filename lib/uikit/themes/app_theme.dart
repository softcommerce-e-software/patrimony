import 'package:flutter/material.dart';
import 'package:patrimony/uikit/themes/app_colors.dart';
import 'package:patrimony/uikit/themes/app_text_styles.dart';

class AppTheme {
  final BuildContext context;

  AppTheme({required this.context});

  static final TextTheme _textTheme = TextTheme(
    labelSmall: AppTextStyles.smallText10,
    labelMedium: AppTextStyles.smallText10Medium,
    labelLarge: AppTextStyles.smallText10Bold,
    bodySmall: AppTextStyles.smallText12Medium,
    bodyMedium: AppTextStyles.smallText12Bold,
    bodyLarge: AppTextStyles.smallText14Medium,
    titleSmall: AppTextStyles.regularText16Medium,
    titleMedium: AppTextStyles.regularText16SemiBold,
    titleLarge: AppTextStyles.regularText16Bold,
    displaySmall: AppTextStyles.mediumText20Medium,
    displayMedium: AppTextStyles.mediumText20SemiBold,
    displayLarge: AppTextStyles.largeText40SemiBold,
  );

  ThemeData lightMode() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.neutral_100,
        primaryColorLight: AppColors.neutral_50,
        primaryColorDark: AppColors.neutral_900,
        disabledColor: AppColors.neutral_500,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.neutral_100,
              secondary: AppColors.neutral_900,
              tertiary: AppColors.blue,
              surface: AppColors.green,
              error: AppColors.red,
              onBackground: AppColors.neutral_700,
            ),
        textTheme: _textTheme,
      );

  ThemeData darkMode() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.neutral_900,
        primaryColorLight: AppColors.neutral_50,
        primaryColorDark: AppColors.neutral_900,
        disabledColor: AppColors.neutral_500,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.neutral_900,
              secondary: AppColors.neutral_100,
              tertiary: AppColors.blue,
              surface: AppColors.green,
              error: AppColors.red,
              onBackground: AppColors.neutral_700,
            ),
        textTheme: _textTheme,
      );
}
