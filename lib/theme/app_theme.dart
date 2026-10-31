import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales
  static const Color rojoNetflix = Color(0xFFE50914);
  static const Color negro = Color(0xFF000000);
  static const Color grisOscuro = Color(0xFF141414);
  static const Color grisCard = Color(0xFF1F1F1F);
  static const Color grisTexto = Color(0xFFB3B3B3);
  static const Color blanco = Color(0xFFFFFFFF);

  static ThemeData get temaOscuro {
    // Texto normal: Roboto
    final textoBase = GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: negro,
      primaryColor: rojoNetflix,
      colorScheme: const ColorScheme.dark(
        primary: rojoNetflix,
        secondary: rojoNetflix,
        surface: grisOscuro,
        onPrimary: blanco,
        onSurface: blanco,
      ),

      textTheme: textoBase.copyWith(
        // Títulos: Bebas Neue
        displayLarge: GoogleFonts.bebasNeue(fontSize: 48, color: blanco, letterSpacing: 1.5),
        displayMedium: GoogleFonts.bebasNeue(fontSize: 36, color: blanco, letterSpacing: 1.2),
        headlineLarge: GoogleFonts.bebasNeue(fontSize: 32, color: blanco, letterSpacing: 1.2),
        headlineMedium: GoogleFonts.bebasNeue(fontSize: 26, color: blanco, letterSpacing: 1),
        // Subtítulos: Montserrat
        titleLarge: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: blanco),
        titleMedium: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: blanco),
        titleSmall: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: grisTexto),
        // Texto normal: Roboto
        bodyLarge: GoogleFonts.roboto(fontSize: 16, color: blanco),
        bodyMedium: GoogleFonts.roboto(fontSize: 14, color: grisTexto),
        bodySmall: GoogleFonts.roboto(fontSize: 12, color: grisTexto),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: negro,
        foregroundColor: blanco,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.bebasNeue(
          fontSize: 34,
          color: rojoNetflix,
          letterSpacing: 2,
        ),
        iconTheme: const IconThemeData(color: blanco),
      ),

      cardTheme: CardThemeData(
        color: grisCard,
        elevation: 4,
        margin: const EdgeInsets.all(6),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      iconTheme: const IconThemeData(color: blanco),
    );
  }
}
