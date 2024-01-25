import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrimony/uikit/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _createTextStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 10.0,
    Color color = AppColors.neutral_900,
  }) {
    return GoogleFonts.poppins(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle smallText10 = _createTextStyle();

  static TextStyle smallText10Medium = _createTextStyle(
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallText10SemiBold = _createTextStyle(
    fontWeight: FontWeight.w600,
  );
  static TextStyle smallText10Bold = _createTextStyle(
    fontWeight: FontWeight.w700,
  );

  static TextStyle smallText12 = _createTextStyle(
    fontSize: 12.0,
  );
  static TextStyle smallText12Medium = _createTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );
  static TextStyle smallText12SemiBold = _createTextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  );
  static TextStyle smallText12Bold = _createTextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12.0,
  );

  static TextStyle smallText14Medium = _createTextStyle(
    fontSize: 14.0,
  );

  static TextStyle regularText16 = _createTextStyle(
    fontSize: 16.0,
  );
  static TextStyle regularText16Medium = _createTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );
  static TextStyle regularText16SemiBold = _createTextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );
  static TextStyle regularText16Bold = _createTextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  );

  static TextStyle mediumText20Medium = _createTextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  );
  static TextStyle mediumText20SemiBold = _createTextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );

  static TextStyle largeText40SemiBold = _createTextStyle(
    fontSize: 40.0,
  );
}
