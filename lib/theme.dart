import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    ColorScheme scheme = lightColorScheme ??
        ColorScheme.fromSeed(seedColor: const Color(0xFF009688));
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(
            fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: GoogleFonts.montserrat(
            fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headline3:
        GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
        headline4: GoogleFonts.montserrat(
            fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
        headline6: GoogleFonts.montserrat(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        subtitle2: GoogleFonts.montserrat(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyText2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        caption: GoogleFonts.roboto(
            fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        overline: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      ),
    );
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    ColorScheme scheme = darkColorScheme ??
        ColorScheme.fromSeed(
            seedColor: const Color(0xFF009688), brightness: Brightness.dark);
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(
            fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: GoogleFonts.montserrat(
            fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headline3:
        GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
        headline4: GoogleFonts.montserrat(
            fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
        headline6: GoogleFonts.montserrat(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: GoogleFonts.montserrat(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        subtitle2: GoogleFonts.montserrat(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyText2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        caption: GoogleFonts.roboto(
            fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        overline: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      ),
    );
  }
}