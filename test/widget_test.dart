import 'package:flutter_test/flutter_test.dart';

import 'package:lab_s10/data/datos.dart';

void main() {
  test('Cada lista tiene 6 elementos con las llaves requeridas', () {
    for (final lista in [peliculasPopulares, tendencias, continuarViendo]) {
      expect(lista.length, 6);
      for (final item in lista) {
        expect(item.keys, containsAll(['titulo', 'anio', 'genero', 'imagen']));
      }
    }
  });

  test('El progreso de continuarViendo está entre 0 y 1', () {
    for (final item in continuarViendo) {
      final progreso = double.parse(item['progreso']!);
      expect(progreso, inInclusiveRange(0, 1));
    }
  });
}
