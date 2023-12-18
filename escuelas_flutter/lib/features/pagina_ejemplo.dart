import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
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
          child: EscuelasBoton.texto(
              context: context,
              color: Colors.red,
              estaHabilitado: true,
              fontSize: 16,
              texto: 'Ingresar',
              onTap: () {}),
        ),
      ),
    );
  }
}
