import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

// TODO(anyone): HACER FACTORY

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
            Tipo.docenteAprobado => DesplegableCurso(
                contenido: Column(
                  children: state.usuario?.asignaturas
                          ?.map(
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
                                  (e.asignatura?.idCurso ?? 0).toString(),
                                  style: TextStyle(
                                    color: colores.grisSC,
                                    fontSize: 14.pf,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            Tipo.docentePendiente => DesplegableCurso(
                contenido: Column(
                  children: state.usuarioPendiente?.asignaturasSolicitadas
                          ?.map(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.nombreAsignatura,
                                  style: TextStyle(
                                    color: colores.grisSC,
                                    fontSize: 14.pf,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  e.nombreCurso,
                                  style: TextStyle(
                                    color: colores.grisSC,
                                    fontSize: 14.pf,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            Tipo.alumnoAprobado => Container(
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
                          '${state.nombreComisionesUsuario(context)}',
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
              ),
            Tipo.alumnoPendiente => Container(
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
                          '${state.nombreComisionesUsuarioPendiente(context)}',
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
          },
        );
      },
    );
  }
}

/// {@template DesplegableCurso}
/// Desplegable de informacion de cursos
/// {@endtemplate}
class DesplegableCurso extends StatelessWidget {
  /// {@macro DesplegableCurso}
  const DesplegableCurso({
    required this.contenido,
    super.key,
  });

  /// Contenido
  final Widget contenido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return ExpansionTile(
      title: Text(
        l10n.commonCourses,
        style: TextStyle(
          color: colores.onBackground,
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
      backgroundColor: colores.tertiary,
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
                child: contenido,
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
