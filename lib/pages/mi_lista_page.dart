import 'package:flutter/material.dart';

import '../data/datos.dart';
import '../widgets/imagen_red.dart';

class MiListaPage extends StatelessWidget {
  const MiListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('MI LISTA')),
      body: ListView(
        children: peliculasPopulares
            .map(
              (item) => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minLeadingWidth: 100,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 100,
                    height: 60,
                    child: ImagenRed(item['imagen']!),
                  ),
                ),
                title: Text(item['titulo']!, style: textos.titleMedium),
                subtitle: Text(
                  '${item['genero']} • ${item['anio']}',
                  style: textos.bodySmall,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () =>
                    Navigator.pushNamed(context, '/detalle', arguments: item),
              ),
            )
            .toList(),
      ),
    );
  }
}
