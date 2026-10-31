import 'dart:async';

import 'package:flutter/material.dart';

// Celular dibujado con código para mostrar la app en Chrome como en un teléfono
class MarcoCelular extends StatefulWidget {
  final Widget child;

  const MarcoCelular({super.key, required this.child});

  @override
  State<MarcoCelular> createState() => _MarcoCelularState();
}

class _MarcoCelularState extends State<MarcoCelular> {
  // Medidas del celular
  static const double _ancho = 390;
  static const double _alto = 844;
  static const double _grosorMarco = 12;
  static const double _grosorBorde = 1.5;
  static const double _radio = 50;
  static const double _altoBarraEstado = 48;
  static const double _altoBarraInicio = 28;
  static const double _anchoBoton = 4;

  // Área de la pantalla donde va la app
  static const double _anchoPantalla = _ancho - _grosorMarco * 2;
  static const double _altoApp =
      _alto - _grosorMarco * 2 - _altoBarraEstado - _altoBarraInicio;

  late DateTime _ahora;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _ahora = DateTime.now();
    // Espera al inicio del siguiente minuto y luego actualiza cada minuto
    final restante = Duration(seconds: 60 - _ahora.second);
    _timer = Timer(restante, () {
      _actualizarHora();
      _timer = Timer.periodic(
        const Duration(minutes: 1),
        (_) => _actualizarHora(),
      );
    });
  }

  void _actualizarHora() {
    if (mounted) setState(() => _ahora = DateTime.now());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _hora =>
      '${_ahora.hour.toString().padLeft(2, '0')}:'
      '${_ahora.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    // En pantallas angostas (celular real) se muestra la app sin marco
    if (media.size.width < 500) return widget.child;

    return Material(
      color: const Color(0xFF0B0B0B),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: _ancho + _anchoBoton * 2,
              height: _alto,
              child: Stack(
                children: [
                  // Botones laterales decorativos
                  _botonLateral(izquierda: true, top: 120, alto: 30),
                  _botonLateral(izquierda: true, top: 175, alto: 60),
                  _botonLateral(izquierda: true, top: 250, alto: 60),
                  _botonLateral(izquierda: false, top: 200, alto: 95),

                  // Cuerpo del celular
                  Positioned(
                    left: _anchoBoton,
                    top: 0,
                    width: _ancho,
                    height: _alto,
                    child: Container(
                      // El borde gris ocupa espacio, así que se descuenta
                      // del padding para que el marco mida 12 px en total
                      padding: const EdgeInsets.all(_grosorMarco - _grosorBorde),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(_radio),
                        border: Border.all(
                          color: const Color(0xFF3A3A3A),
                          width: _grosorBorde,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x66000000),
                            blurRadius: 40,
                            spreadRadius: 4,
                            offset: Offset(0, 16),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(_radio - _grosorMarco),
                        child: ColoredBox(
                          color: Colors.black,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  _barraEstado(),
                                  SizedBox(
                                    width: _anchoPantalla,
                                    height: _altoApp,
                                    // La app recibe el tamaño de la pantalla
                                    // del celular, sin márgenes del sistema
                                    child: MediaQuery(
                                      data: media.copyWith(
                                        size: const Size(
                                          _anchoPantalla,
                                          _altoApp,
                                        ),
                                        padding: EdgeInsets.zero,
                                        viewPadding: EdgeInsets.zero,
                                        viewInsets: EdgeInsets.zero,
                                      ),
                                      child: widget.child,
                                    ),
                                  ),
                                  _barraInicio(),
                                ],
                              ),
                              // Isla dinámica
                              Positioned(
                                top: 10,
                                left: (_anchoPantalla - 120) / 2,
                                child: Container(
                                  width: 120,
                                  height: 34,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                    // Contorno sutil para que se note
                                    // sobre el fondo negro
                                    border: Border.all(
                                      color: const Color(0xFF262626),
                                    ),
                                  ),
                                  // Lente de la cámara
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF1A1A2E),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _barraEstado() {
    return SizedBox(
      height: _altoBarraEstado,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          children: [
            Text(
              _hora,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.signal_cellular_alt, color: Colors.white, size: 17),
            const SizedBox(width: 4),
            const Icon(Icons.wifi, color: Colors.white, size: 17),
            const SizedBox(width: 4),
            const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.battery_full, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barraInicio() {
    return SizedBox(
      height: _altoBarraInicio,
      child: Center(
        child: Container(
          width: 130,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _botonLateral({
    required bool izquierda,
    required double top,
    required double alto,
  }) {
    return Positioned(
      left: izquierda ? 0 : null,
      right: izquierda ? null : 0,
      top: top,
      child: Container(
        width: _anchoBoton + 2,
        height: alto,
        decoration: BoxDecoration(
          color: const Color(0xFF4A4A4A),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
