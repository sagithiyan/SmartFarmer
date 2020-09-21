import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfarmer/src/styles/colors.dart';

abstract class TextStyles {
  static TextStyle get title {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: AppColors.darkblue,
            fontWeight: FontWeight.bold,
            fontSize: 40.0));
  }

  static TextStyle get erroralert {
    return GoogleFonts.economica(
        textStyle: TextStyle(
            color: AppColors.red, fontWeight: FontWeight.bold, fontSize: 30.0));
  }

  static TextStyle get subtitle {
    //economica used
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30.0));
  }

  static TextStyle get listTitle {
    //economica used
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0));
  }


  static TextStyle get navTitle {
    return GoogleFonts.poppins(
        textStyle:
            TextStyle(color: AppColors.darkblue, fontWeight: FontWeight.bold));
  }

  static TextStyle get navTitleMaterial {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }

  static TextStyle get body {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.darkgray, fontSize: 16.0));
  }

  static TextStyle get bodyLightBlue {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.lightblue, fontSize: 16.0));
  }

  static TextStyle get bodyRed {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.red, fontSize: 16.0));
  }

  static TextStyle get picker {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.darkgray, fontSize: 30.0));
  }

  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.lightgray, fontSize: 14.0));
  }

  static TextStyle get error {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.red, fontSize: 12.0));
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold));
  }

  static TextStyle get buttonTextDark {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.darkgray,
            fontSize: 17.0,
            fontWeight: FontWeight.bold));
  }
}
