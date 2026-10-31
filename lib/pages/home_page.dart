import 'package:flutter/material.dart';

import '../data/datos.dart';
import '../theme/app_theme.dart';
import '../widgets/imagen_red.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 36),
        actions: const [
          Icon(Icons.cast),
          SizedBox(width: 16),
          Icon(Icons.search),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        children: [
          _bannerDestacado(context),
          _tituloSeccion(context, 'Populares'),
          _listaHorizontal(context, peliculasPopulares),
          _tituloSeccion(context, 'Tendencias'),
          _listaHorizontal(context, tendencias),
          _tituloSeccion(context, 'Continuar viendo', accion: 'Ver todo'),
          ...continuarViendo.map((item) => _itemContinuar(context, item)),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.grisOscuro,
        selectedItemColor: AppTheme.blanco,
        unselectedItemColor: AppTheme.grisTexto,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined),
            label: 'Pronto',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  // Banner destacado con imagen local, título y botones
  Widget _bannerDestacado(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/banner.png',
            height: 420,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Degradado para que el texto se lea sobre la imagen
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.9)],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                Text('DUNE', style: textos.displayLarge),
                Text(
                  'Ciencia ficción • Aventura • Épica',
                  style: textos.titleSmall,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.blanco,
                          foregroundColor: AppTheme.negro,
                        ),
                        icon: const Icon(Icons.play_arrow),
                        // FittedBox evita que el texto se parta en pantallas angostas
                        label: FittedBox(
                          child: Text(
                            'Reproducir',
                            style: textos.titleMedium?.copyWith(color: AppTheme.negro),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/mi-lista'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.grisCard,
                          foregroundColor: AppTheme.blanco,
                        ),
                        icon: const Icon(Icons.add),
                        label: FittedBox(
                          child: Text('Mi lista', style: textos.titleMedium),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Título de sección con Bebas Neue y, opcionalmente, un texto rojo a la derecha
  Widget _tituloSeccion(BuildContext context, String titulo, {String? accion}) {
    final textos = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
      child: Row(
        children: [
          Text(titulo, style: textos.headlineMedium),
          const Spacer(),
          if (accion != null)
            Text(
              accion,
              style: textos.titleSmall?.copyWith(
                color: AppTheme.rojoNetflix,
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }

  // Fila horizontal de pósters
  Widget _listaHorizontal(
    BuildContext context,
    List<Map<String, String>> lista,
  ) {
    return SizedBox(
      height: 190,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        children: lista
            .map(
              (item) => SizedBox(
                width: 125,
                child: Card(
                  child: InkWell(
                    onTap: () => _abrirDetalle(context, item),
                    child: ImagenRed(item['imagen']!),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Tarjeta de "Continuar viendo": miniatura con play y progreso, datos y menú
  Widget _itemContinuar(BuildContext context, Map<String, String> item) {
    final textos = Theme.of(context).textTheme;
    final progreso = double.parse(item['progreso']!);
    // Tiempo restante de ejemplo, tomando 60 min como duración total
    final minutosRestantes = ((1 - progreso) * 60).round();

    return Card(
      color: const Color(0xFF1A1A1A),
      elevation: 3,
      shadowColor: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _abrirDetalle(context, item),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _miniaturaContinuar(item['imagen']!, progreso),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['titulo']!,
                      style: textos.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _chip(context, item['genero']!, relleno: true),
                        _chip(context, item['anio']!),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Quedan $minutosRestantes min',
                      style: textos.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: AppTheme.grisTexto),
            ],
          ),
        ),
      ),
    );
  }

  // Miniatura con botón de play centrado y barra de progreso pegada abajo
  Widget _miniaturaContinuar(String url, double progreso) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 120,
        height: 72,
        child: Stack(
          children: [
            ImagenRed(url),
            Center(
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: AppTheme.blanco,
                  size: 22,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: LinearProgressIndicator(
                value: progreso,
                color: AppTheme.rojoNetflix,
                backgroundColor: Colors.white24,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Chip pequeño: con fondo gris (género) o solo con borde (año)
  Widget _chip(BuildContext context, String texto, {bool relleno = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: relleno ? const Color(0xFF2A2A2A) : null,
        border: relleno ? null : Border.all(color: const Color(0xFF2A2A2A)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppTheme.blanco,
          fontSize: 11,
        ),
      ),
    );
  }

  void _abrirDetalle(BuildContext context, Map<String, String> item) {
    Navigator.pushNamed(context, '/detalle', arguments: item);
  }
}
