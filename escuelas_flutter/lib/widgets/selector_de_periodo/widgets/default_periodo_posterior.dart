import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class DefaultPeriodoPosterior extends StatelessWidget {
  const DefaultPeriodoPosterior({
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
      padding: EdgeInsets.only(right: 15.pw),
      child: GestureDetector(
        onTap: onSeleccionarPeriodo,
        child: Row(
          children: [
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
            Icon(
              Icons.arrow_right,
              size: 25.pw,
              color: colores.grisSC,
            ),
          ],
        ),
      ),
    );
  }
}
