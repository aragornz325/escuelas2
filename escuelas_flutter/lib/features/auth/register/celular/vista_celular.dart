import 'package:escuelas_flutter/features/auth/register/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularRegistro}
/// Vista de registro para dispositivos móviles.
/// {@endtemplate}
class VistaCelularRegistro extends StatelessWidget {
  /// {@macro VistaCelularRegistro}
  const VistaCelularRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.pw),
              child: const EncabezadoDelRegistro(),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.pw),
                  child: const FormularioRegistro(),
                ),
                SizedBox(height: 40.ph),
                const TextoDerechosReservados(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
