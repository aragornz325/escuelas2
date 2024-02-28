import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/boton_ver_historial_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/enums/textos_valorativos.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template InformacionAlumnoOAsignatura}
/// Información de un alumno o de una asignatura.
/// {@endtemplate}
class InformacionAlumnoOAsignatura extends StatefulWidget {
  /// {@macro InformacionAlumnoOAsignatura}
  const InformacionAlumnoOAsignatura({
    required this.tituloTarjeta,
    required this.promedio,
    this.idAsignatura,
    this.esInfoAlumno = true,
    super.key,
  });

  /// Titulo de la tarjeta ubicado a la izquierda.
  final String tituloTarjeta;

  /// Promedio del alumno
  final double promedio;

  /// Indica si va a redibujarse el componente de acuerdo a la informacion de un
  /// alumno o va mostrarse la asignatura, cambiando funcionalidad.
  final bool esInfoAlumno;

  /// ID de la asignatura para redirigir a la pagina de las calificaciones
  /// anuales de la materia.
  final int? idAsignatura;

  @override
  State<InformacionAlumnoOAsignatura> createState() =>
      _InformacionAlumnoOAsignaturaState();
}

class _InformacionAlumnoOAsignaturaState
    extends State<InformacionAlumnoOAsignatura> {
  /// Indica si el container esta expandido.
  bool estaExpandido = false;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    final rite = devolverRITE(widget.promedio);

    final idAsignatura = widget.idAsignatura;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.sw)),
          color: colores.tertiary,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 5.pw),
          initiallyExpanded: estaExpandido,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.esInfoAlumno)
                Icon(
                  estaExpandido
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  color: colores.grisSC,
                  size: 25.pw,
                ),
              Padding(
                padding: EdgeInsets.only(right: 1.pw),
                child: Text(
                  widget.tituloTarjeta,
                  maxLines: 1,
                  style: TextStyle(
                    color: colores.onBackground,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
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
                widget.esInfoAlumno
                    ? widget.promedio.toStringAsFixed(
                        widget.promedio.truncateToDouble() == widget.promedio
                            ? 0
                            : 2,
                      )
                    : widget.promedio.toString(),
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 13.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.pw),
                child: Text(
                  rite.siglas,
                  style: TextStyle(
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w600,
                    color: rite.colorSegunRITE(context),
                  ),
                ),
              ),
              if (widget.esInfoAlumno)
                Icon(
                  estaExpandido
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  color: colores.grisSC,
                  size: 25.pw,
                ),
              if (!widget.esInfoAlumno && idAsignatura != null)
                BotonVerHistorialAsignatura(
                  idAsignatura: idAsignatura,
                ),
            ],
          ),
          backgroundColor: colores.tertiary,
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
