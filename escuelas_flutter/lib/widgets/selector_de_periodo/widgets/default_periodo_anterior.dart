import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class DefaultPeriodoAnterior extends StatelessWidget {
  const DefaultPeriodoAnterior({
    required this.onSeleccionarPeriodo,
    required this.periodo,
    super.key,
  });

  /// Ejecuta una acción al retroceder el periodo.
  final void Function() onSeleccionarPeriodo;

  final PeriodoDelSelector periodo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      padding: EdgeInsets.only(left: 15.pw),
      child: GestureDetector(
        onTap: onSeleccionarPeriodo,
        child: Row(
          children: [
            Icon(
              Icons.arrow_left,
              size: 25.pw,
              color: colores.grisSC,
            ),
            Text(
              periodo.etiqueta.length < 3
                  ? periodo.etiqueta
                  : periodo.etiqueta.substring(0, 3),
              style: TextStyle(
                color: colores.grisSC,
                fontSize: 14.pf,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
