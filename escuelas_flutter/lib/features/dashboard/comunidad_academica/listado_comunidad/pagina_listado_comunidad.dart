import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/celular/vista_celular_listado_comunidad.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/escritorio/vista_escritorio_listado_comunidad.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaListadoComunidad}
/// Pagina de la comunidad academica donde se muestran los usuarios de la
/// categoria seleccionada
/// {@endtemplate}
@RoutePage()
class PaginaListadoComunidad extends StatelessWidget {
  /// {@macro PaginaListadoComunidad}
  const PaginaListadoComunidad({
    @PathParam('idRol') required this.idRol,
    super.key,
  });

  /// Id del rol seleccionado
  final int idRol;

  @override
  Widget build(BuildContext context) {
    context.read<BlocComunidadAcademica>().add(
          BlocComunidadAcademicaEventoTraerUsuariosPorRol(
            idRol: idRol,
            ordenarPor: OrdenarPor.apellido,
          ),
        );
    return const FullResponsiveScreen(
      celular: VistaCelularListadoComunidad(),
      escritorio: VistaEscritorioListadoComunidad(),
    );
  }
}
