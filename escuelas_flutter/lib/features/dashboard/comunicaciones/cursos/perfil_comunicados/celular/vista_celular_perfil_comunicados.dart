import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularPerfilComunicados}
/// TODO(mati) add docu
/// {@endtemplate}
class VistaCelularPerfilComunicados extends StatelessWidget {
  /// {@macro VistaCelularPerfilComunicados}
  const VistaCelularPerfilComunicados({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alanis marcos', // TODO(mati): hacer que reciba el nombre del usuario/alumno
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16.pf,
                color: colores.onBackground,
              ),
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Divider(height: 0, color: colores.secondary),
            SizedBox(height: max(10.ph, 10.sh)),
            const BotonesAgregarNuevaYMarcarTodosComoLeidos(),

            /// TODO(mati): agregar lista de notificaciones
            const ExpansionTileNotificaciones(),
            const ExpansionTileNotificaciones(),
            const ExpansionTileNotificaciones(),
          ],
        ),
      ),
    );
  }
}
