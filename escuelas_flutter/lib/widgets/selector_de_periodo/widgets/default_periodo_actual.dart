import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class DefaultPeriodoActual extends StatelessWidget {
  const DefaultPeriodoActual({
    required this.periodo,
    super.key,
  });

  final Periodo periodo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          periodo.etiqueta,
          style: TextStyle(
            color: colores.onBackground,
            fontSize: 18.pf,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          periodo.fechaDesde.year.toString(),
          style: TextStyle(
            color: colores.grisSC,
            fontSize: 12.pf,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
