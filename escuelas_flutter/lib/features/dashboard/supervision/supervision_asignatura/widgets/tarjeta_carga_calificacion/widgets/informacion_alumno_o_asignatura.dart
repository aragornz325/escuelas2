import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/boton_ver_historial_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/widgets/widgets.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/enums/textos_valorativos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    this.usuario,
    super.key,
  });
  final Usuario? usuario;

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
  /// Dialog para confirmar el envio de correos.
  void _dialogConfirmarEnvioEmails(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocSupervisionAsignatura>(),
        child: DialogConfirmarEnvioDeEmail(
          usuario: widget.usuario,
        ),
      ),
    );
  }

  /// Indica si el container esta expandido.
  bool estaExpandido = false;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

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
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 1.pw),
                  child: Text(
                    widget.tituloTarjeta,
                    maxLines: 2,
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
              IconButton(
                onPressed: () => _dialogConfirmarEnvioEmails(context),
                icon: Icon(
                  Icons.email_outlined,
                  color: colores.onBackground,
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
