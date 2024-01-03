import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/widgets/escuelas_scaffold.dart';
import 'package:flutter/material.dart';

/// {@template VistaCelularLogin}
// TODO(anyone): AGREGAR DOCUMENTACION.
/// {@endtemplate}
class VistaCelularLogin extends StatelessWidget {
  /// {@macro VistaCelularLogin}
  const VistaCelularLogin({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(ANYONE): Cambiar por el verdadero login
    return EscuelasScaffold(
      index: 1,
      cuerpo: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to your other page here
                context.router.push(
                  RutaInicio(),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
