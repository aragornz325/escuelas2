import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

@RoutePage()
class PaginaEjemplo extends StatelessWidget {
  const PaginaEjemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return FullResponsiveApp(
      child: const Ejemplo(),
    );
  }
}

class Ejemplo extends StatefulWidget {
  const Ejemplo({super.key});

  @override
  State<Ejemplo> createState() => _EjemploState();
}

class _EjemploState extends State<Ejemplo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: EscuelasBoton.outlined(
            height: max(30.ph, 30.sh),
            width: 70.pw,
            estaHabilitado: true,
            texto: 'VOLVER',
            context: context,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
