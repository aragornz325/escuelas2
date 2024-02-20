import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template EscuelasAppBar}
/// Componente de navegacion estatico en conjunto con EscuelasDrawer
/// {@endtemplate}
class EscuelasAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// {@macro EscuelasAppBar}
  const EscuelasAppBar({
    required this.tieneDrawer,
    this.iconoLateralDerecho,
    this.iconoLateralIzquierdo,
    super.key,
  });

  /// Componente que se agrega al final del [EscuelasAppBar]
  /// a la derecha del titulo. Deberia ser un icono con cierta funcionalidad
  final Widget? iconoLateralDerecho;

  /// Componente que se agrega al principio del [EscuelasAppBar] a la izquierda
  /// del titulo.  Deberia ser un icono con cierta funcionalidad
  final Widget? iconoLateralIzquierdo;

  /// Determina si tiene drawer o no
  final bool tieneDrawer;

  @override
  State<EscuelasAppBar> createState() => _EscuelasAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _EscuelasAppBarState extends State<EscuelasAppBar> {
  @override
  void didChangeDependencies() {
    context.router.addListener(_cambiarNombreRuta);

    super.didChangeDependencies();
  }

  late String nombreRutaActual = '';

  /// Asigna el nombre de la ruta actual al cambiarse, para usarla en el titulo
  /// de [EscuelasAppBar]
  void _cambiarNombreRuta() {
    if (!mounted) return;

    final rutas = context.router.current.name;

    final l10n = context.l10n;

    setState(
      () => nombreRutaActual = switch (rutas) {
        RutaInicio.name => l10n.routeNameHome,
        RutaLogin.name => l10n.routeNameLogin,
        RutaInasistencia.name => l10n.routeNameAbsences,
        RutaComunidadAcademica.name => l10n.routeNameAcademicCommunity,
        RutaKyc.name => l10n.routeNameKyc,
        RutaSeleccionDeRol.name => l10n.routeRoleSelection,
        RutaFormulario.name => l10n.routeNameForm,
        RutaEspera.name => l10n.routeNameAwaitApproval,
        RutaDashboard.name => l10n.routeNameDashboard,
        RutaPerfilUsuario.name => l10n.routeNameUserProfile,
        RutaPerfilUsuarioPendiente.name => l10n.routeNamePendingUserProfile,
        RutaListaCursos.name => l10n.routeNameCourses,
        RutaComisiones.name => l10n.commonComissions,
        RutaListaDeComisiones.name => l10n.commonComissions,
        RutaCargaDeCalificaciones.name => l10n.routeUploadGrades,
        RutaUsuariosPendientes.name => l10n.routeNamePendingUsers,
        RutaMenuComunidadAcademica.name => l10n.routeAcademicCommunityMenu,
        RutaListadoComunidad.name => l10n.routeAcademicCommunityList,
        RutaSupervisionComisiones.name => l10n.routeNameCommissionSupervision,
        RutaSupervisionEnvioCalificaciones.name =>
          l10n.routeNameGradeSubmissionSupervision,
        _ => '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconoLateralIzquierdo = widget.iconoLateralIzquierdo;

    final iconoLateralDerecho = widget.iconoLateralDerecho;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return iconoLateralIzquierdo ??
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        if (widget.tieneDrawer) {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                    );
              },
            ),
            title: Center(
              child: BlocBuilder<BlocDashboard, BlocDashboardEstado>(
                builder: (context, state) {
                  if (state is BlocDashboardEstadoCargando) {
                    return const CircularProgressIndicator();
                  }
                  if (state.asignatura != null &&
                      state.comision != null &&
                      context.router.topMatch.name ==
                          RutaGestionDeComision.name) {
                    return Text(
                      '${state.asignatura!.nombre.toUpperCase()}'
                      ' ${state.comision!.nombre.toUpperCase()}',
                    );
                  }
                  return Text(
                    nombreRutaActual,
                  );
                },
              ),
            ),
            actions: <Widget>[
              iconoLateralDerecho ??
                  InkWell(
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) =>
                          EscuelasDialog.featNoDisponible(context: context),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.notifications_none_rounded),
                    ),
                  ),
            ],
            pinned: true,
          ),
        ],
      ),
    );
  }
}
