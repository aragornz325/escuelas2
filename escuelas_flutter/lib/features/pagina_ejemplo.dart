import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:flutter/material.dart';

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

class Ejemplo extends StatelessWidget {
  const Ejemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('nada');
  }
}
