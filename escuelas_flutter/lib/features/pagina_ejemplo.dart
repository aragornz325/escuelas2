import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
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
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.brown),
        width: 800.pw,
        height: 800.ph,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EscuelasTextFieldPassword(
                controller: controller,
              ),
            ),
            SizedBox(height: 10.ph),
            Padding(
              padding: EdgeInsets.all(8),
              child: EscuelasTextfield.email(
                controller: controller2,
                context: context,
              ),
            ),
            SizedBox(height: 10.ph),
            Padding(
              padding: EdgeInsets.all(8),
              child: EscuelasTextfield.soloNumero(
                hintText: 'DNI',
                controller: controller3,
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
