import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/elemento_listado_comunidad.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularGestionDeComision}
/// TODO(mati): documentar
/// {@endtemplate}
class VistaCelularGestionDeComision extends StatelessWidget {
  /// {@macro VistaCelularGestionDeComision}
  const VistaCelularGestionDeComision({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Column(
        children: [
          ComponenteDependiendoElRol(
            tituloDeRol: '${l10n.commonTeacher}:',
            onTap: () {
              // TODO(mati): agregarle funcionalidad de asignar docente
            },
            tituloBoton: l10n.pageManagementOfCourseAssignTeacher,
          ),
          // TODO(mati): agregarle Condicion de que si no hay docente
          // asignado a esta asignatura mostrar el texto sino el nombre
          // del docente con la imagen.
          Row(
            children: [
              CircleAvatar(
                radius: 18.sw,
                backgroundColor: colores.secondary,
              ),
              SizedBox(width: 10.pw),
              Text(
                l10n.pageManagementOfCourseThereAreNoTeachersAssigned,
                style: TextStyle(
                  fontSize: 13.pf,
                  fontWeight: FontWeight.w400,
                  color: colores.secondary,
                ),
              ),
            ],
          ),
          ComponenteDependiendoElRol(
            tituloDeRol: '${l10n.commonStudent}:',
            onTap: () {
              // TODO(mati): agregarle funcionalidad de agregar alumno
            },
            tituloBoton: l10n.pageManagementOfCourseAddStudent,
          ),
          BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
            builder: (context, state) {
              if (state.listaAlumnos?.usuariosListados.isEmpty ?? false) {
                return Center(
                  child: Text(
                    l10n.pageAcademicCommunityNoUsersToShow,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 16.pf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.listaAlumnos?.usuariosListados
                            .map(
                              (e) => e.usuarios.isEmpty
                                  ? Container()
                                  : ElementoListadoComunidad(
                                      ordenarPor: OrdenarPor.asignatura,
                                      titulo: e.etiquetaDelIndexListado
                                          .toUpperCase(),
                                      usuariosListados: e,
                                      onTap: () {
                                        // TODO(mati) : hacer un bottonshit
                                      },
                                    ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// {@template Componente}
/// TODO(mati): documentar.
/// {@endtemplate}
class ComponenteDependiendoElRol extends StatelessWidget {
  /// {@macro Componente}
  const ComponenteDependiendoElRol({
    required this.tituloDeRol,
    required this.tituloBoton,
    required this.onTap,
    super.key,
  });

  /// Titulo del rol ej: Docente o Alumno.
  final String tituloDeRol;

  /// Titulo del boton.
  final String tituloBoton;

  /// Funcion que se ejecuta al presionar el boton.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tituloDeRol,
              style: TextStyle(
                color: colores.secondary,
                fontSize: 13.pf,
                fontWeight: FontWeight.w800,
              ),
            ),
            EscuelasBoton.textoEIcono(
              color: colores.primary,
              onTap: onTap,
              texto: tituloBoton,
              context: context,
              icono: Icons.person_add_alt_outlined,
            ),
          ],
        ),
        Divider(
          color: colores.secondary,
          height: max(5.ph, 5.sh),
        ),
      ],
    );
  }
}
