import 'package:flutter/material.dart';

import 'pages/detalle_page.dart';
import 'pages/home_page.dart';
import 'pages/mi_lista_page.dart';
import 'theme/app_theme.dart';
import 'widgets/marco_celular.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.temaOscuro,
      // Muestra la app dentro de un celular dibujado (solo en pantallas anchas)
      builder: (context, child) => MarcoCelular(child: child!),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detalle': (context) => const DetallePage(),
        '/mi-lista': (context) => const MiListaPage(),
      },
    );
  }
}
