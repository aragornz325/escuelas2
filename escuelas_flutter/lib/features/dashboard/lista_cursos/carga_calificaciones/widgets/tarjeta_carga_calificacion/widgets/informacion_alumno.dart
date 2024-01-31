import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/constantes/textos_valorativos.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template InformacionAlumno}
/// Información de un alumno
/// {@endtemplate}
class InformacionAlumno extends StatefulWidget {
  /// {@macro InformacionAlumno}
  const InformacionAlumno({
    required this.nombreAlumno,
    required this.promedio,
    super.key,
  });

  /// Nombre del alumno
  final String nombreAlumno;

  /// Promedio del alumno
  final double promedio;

  @override
  State<InformacionAlumno> createState() => _InformacionAlumnoState();
}

class _InformacionAlumnoState extends State<InformacionAlumno> {
  /// Indica si el container esta expandido.
  bool estaExpandido = false;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    final rite = devolverRITE(widget.promedio);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.sw)),
          color: colores.marfilBackgroundDesktop,
        ),
        child: ExpansionTile(
          initiallyExpanded: estaExpandido,
          title: Text(
            widget.nombreAlumno,
            maxLines: 1,
            style: TextStyle(
              color: colores.onBackground,
              overflow: TextOverflow.ellipsis,
              fontSize: 13.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sw),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.sw),
          ),
          onExpansionChanged: (value) => setState(() => estaExpandido = value),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.pageGradesStudentCardAverage,
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 13.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.promedio.toStringAsFixed(
                  widget.promedio.truncateToDouble() == widget.promedio ? 0 : 2,
                ),
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 13.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5.pw),
              Text(
                rite.siglas,
                style: TextStyle(
                  fontSize: 13.pf,
                  color: rite.colorSegunRITE(context),
                ),
              ),
              Icon(
                estaExpandido
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                color: colores.grisSC,
                size: 25.pw,
              ),
            ],
          ),
          backgroundColor: colores.marfilBackgroundDesktop,
          children: <Widget>[
            Divider(
              height: .1,
              color: colores.grisSC,
            ),
            ListTile(
              title: Text(
                rite.valorativoSegunRITE(),
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 12.pf,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.sw),
                  bottomRight: Radius.circular(20.sw),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
