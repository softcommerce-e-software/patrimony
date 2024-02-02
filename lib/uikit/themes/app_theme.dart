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
    titleSmall: AppTextStyles.smallText14Bold,
    titleMedium: AppTextStyles.regularText16Medium,
    titleLarge: AppTextStyles.regularText16SemiBold,
    displaySmall: AppTextStyles.regularText16Bold,
    displayMedium: AppTextStyles.mediumText20Medium,
    displayLarge: AppTextStyles.mediumText20SemiBold,
    headlineSmall: AppTextStyles.largeText40SemiBold,
  );

  ThemeData lightMode() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.neutral_100,
        primaryColorLight: AppColors.neutral_50,
        primaryColorDark: AppColors.neutral_900,
        dividerColor: AppColors.neutral_300,
        disabledColor: AppColors.neutral_400,
        shadowColor: AppColors.neutral_900.withOpacity(0.25),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.neutral_200,
              secondary: AppColors.neutral_800,
              tertiary: AppColors.blue,
              surface: AppColors.green,
              error: AppColors.red,
              onBackground: AppColors.neutral_700,
              onPrimary: AppColors.neutral_500,
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
        dividerColor: AppColors.neutral_300,
        disabledColor: AppColors.neutral_400,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.neutral_900,
              secondary: AppColors.neutral_100,
              tertiary: AppColors.blue,
              surface: AppColors.green,
              error: AppColors.red,
              onBackground: AppColors.neutral_700,
              onPrimary: AppColors.neutral_500,
            ),
        textTheme: _textTheme,
      );
}
