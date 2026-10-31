import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Imagen de internet con respaldo si falla la carga
class ImagenRed extends StatelessWidget {
  final String url;

  const ImagenRed(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppTheme.grisCard,
        child: const Icon(Icons.broken_image, color: AppTheme.grisTexto),
      ),
    );
  }
}
