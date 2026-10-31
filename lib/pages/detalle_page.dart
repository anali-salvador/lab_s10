import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/imagen_red.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pelicula =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Póster grande con degradado inferior
          SizedBox(
            height: 480,
            child: Stack(
              children: [
                ImagenRed(pelicula['imagen']!),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppTheme.negro],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bloque de información
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pelicula['titulo']!.toUpperCase(), style: textos.displayMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${pelicula['anio']} • ${pelicula['genero']}',
                    style: textos.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Una historia llena de giros que te mantendrá al borde del '
                    'asiento. Personajes inolvidables, escenas impactantes y un '
                    'final que nadie espera. Disponible ahora en tu lista.',
                    style: textos.bodyMedium?.copyWith(height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.blanco,
                        foregroundColor: AppTheme.negro,
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: Text(
                        'Reproducir',
                        style: textos.titleMedium?.copyWith(color: AppTheme.negro),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.grisOscuro,
                        foregroundColor: AppTheme.blanco,
                      ),
                      icon: const Icon(Icons.add),
                      label: Text('Mi lista', style: textos.titleMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
