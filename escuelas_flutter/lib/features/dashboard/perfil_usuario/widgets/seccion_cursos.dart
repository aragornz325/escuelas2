import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/widget/dialog_seleccionar_asignatura_docente.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/widget/dialog_quitar_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

// TODO(anyone): HACER FACTORY
//! TODO(anyone): Extraer widget

/// {@template SeccionCursos}
/// Seccion de cursos del perfil de usuario donde se puede ver a que cursos esta
/// asignado el usuario
/// {@endtemplate}
class SeccionCursos extends StatelessWidget {
  /// {@macro SeccionCursos}
  const SeccionCursos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.pw,
            vertical: 14.ph,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.sw)),
            color: colores.tertiary,
          ),
          child: switch (state.tipoUsuario) {
            Tipo.docenteAprobado => _DesplegableCurso(
                idUsuario: state.usuario?.id ?? 0,
                asignaturas: state.listaAsignaturasUsuario,
                contenido: Column(
                  children: state.listaAsignaturasUsuario
                      .map(
                        (e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.asignatura?.nombre ?? '',
                              style: TextStyle(
                                color: colores.grisSC,
                                fontSize: 14.pf,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              e.comision?.nombre ?? '',
                              style: TextStyle(
                                color: colores.grisSC,
                                fontSize: 14.pf,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            Tipo.docentePendiente => state
                    .listaAsignaturasSolicitadasUsuarioPendiente.isNotEmpty
                ? _DesplegableCurso(
                    idUsuario: state.usuario?.id ?? 0,
                    asignaturas: state.listaAsignaturasUsuario,
                    contenido: Column(
                      children: state
                          .listaAsignaturasSolicitadasUsuarioPendiente
                          .map(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.asignatura?.nombre ?? '',
                                  style: TextStyle(
                                    color: colores.grisSC,
                                    fontSize: 14.pf,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  e.comision?.nombre ?? '',
                                  style: TextStyle(
                                    color: colores.grisSC,
                                    fontSize: 14.pf,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  )
                : ElementoLista.sinDatos(
                    texto: '${l10n.commonComissions.toUpperCase()}: '
                        '*${l10n.commonNoData}* ',
                    context: context,
                  ),
            Tipo.alumnoAprobado => state.listaComisionesDelUsuario.isNotEmpty
                ? Container(
                    height: 45.ph,
                    padding: EdgeInsets.symmetric(horizontal: 20.pw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.sw),
                      color: colores.tertiary,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.pw),
                        child: Row(
                          children: [
                            Text(
                              '${l10n.commonComission.toUpperCase()}: '
                              '${state.nombreComisiones}',
                              style: TextStyle(
                                color: colores.onBackground,
                                fontSize: 13.pf,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ElementoLista.sinDatos(
                    texto: '${l10n.commonComission.toUpperCase()}: '
                        '*${l10n.commonNoData}* ',
                    context: context,
                  ),
            Tipo.alumnoPendiente =>
              state.usuarioPendiente?.comisionSolicitada != null
                  ? Container(
                      height: 45.ph,
                      width: 340.pw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.sw),
                        color: colores.tertiary,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.pw),
                          child: Row(
                            children: [
                              Text(
                                '${l10n.commonComission.toUpperCase()}: '
                                '${state.nombreComisionSolicitada}',
                                style: TextStyle(
                                  color: colores.onBackground,
                                  fontSize: 13.pf,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ElementoLista.sinDatos(
                      texto: '${l10n.commonComission.toUpperCase()}: '
                          '*${l10n.commonNoData}* ',
                      context: context,
                    )
          },
        );
      },
    );
  }
}

/// {@template DesplegableCurso}
/// Desplegable de informacion de cursos
/// {@endtemplate}
class _DesplegableCurso extends StatefulWidget {
  /// {@macro DesplegableCurso}
  const _DesplegableCurso({
    required this.contenido,
    required this.asignaturas,
    required this.idUsuario,
  });

  /// Contenido
  final Widget contenido;

  /// Lista de asignaturas que tiene el usuario
  final List<RelacionAsignaturaUsuario> asignaturas;

  /// Id del usuario
  final int idUsuario;

  @override
  State<_DesplegableCurso> createState() => _DesplegableCursoState();
}

class _DesplegableCursoState extends State<_DesplegableCurso> {
  /// Muestra el popup para seleccionar una asignatura y su respectiva comision
  Future<void> _onSeleccionadorAsignaturaPorComision(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: SeleccionarAsignaturaParaDocente(
            idUsuario: widget.idUsuario,
          ),
        );
      },
    );
  }

  /// Muestra un Dialog para selecciona una asignatura a desasignar de la lista
  /// del docente
  Future<void> _quitarAsignatura(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: DialogQuitarAsignatura(
            asignaturas: widget.asignaturas,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return ExpansionTile(
      trailing: GestureDetector(
        onTap: () {
          _quitarAsignatura(context);
        },
        child: Icon(
          Icons.delete_outline_outlined,
          color: colores.error,
          size: 20.sw,
        ),
      ),
      title: Row(
        children: [
          Text(
            l10n.commonCourses,
            style: TextStyle(
              color: colores.onBackground,
              fontSize: 13.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          EscuelasBoton.textoEIcono(
            color: colores.primary,
            onTap: () {
              _onSeleccionadorAsignaturaPorComision(context);
            },
            texto: l10n.pageUserProfileButtonAddSubject,
            context: context,
            icono: Icons.add,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sw),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.sw),
      ),
      backgroundColor: colores.tertiary,
      iconColor: colores.error,
      children: <Widget>[
        Divider(
          height: .5,
          thickness: .5,
          color: colores.grisSC,
        ),
        ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.commonSubject,
                    style: TextStyle(
                      color: colores.grisSC,
                      fontSize: 14.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.commonCourse,
                    style: TextStyle(
                      color: colores.grisSC,
                      fontSize: 14.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 14.ph),
                child: widget.contenido,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.sw),
              bottomRight: Radius.circular(20.sw),
            ),
          ),
        ),
      ],
    );
  }
}

enum Tipo {
  docenteAprobado,
  docentePendiente,
  alumnoAprobado,
  alumnoPendiente;
}
