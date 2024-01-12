import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template EscuelasAppBar}
/// Componente de navegacion estatico en conjunto con EscuelasDrawer
/// {@endtemplate}
class EscuelasAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// {@macro EscuelasAppBar}
  const EscuelasAppBar({
    super.key,
    this.iconoLateralDerecho,
    this.iconoLateralIzquierdo,
  });

  /// Componente que se agrega al final del [EscuelasAppBar]
  /// a la derecha del titulo. Deberia ser un icono con cierta funcionalidad
  final Widget? iconoLateralDerecho;

  /// Componente que se agrega al principio del [EscuelasAppBar] a la izquierda
  /// del titulo.  Deberia ser un icono con cierta funcionalidad
  final Widget? iconoLateralIzquierdo;

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
    final rutas = context.router.current.name;

    final l10n = context.l10n;
    setState(() {
      /// Cada vez que se cambia de ruta, se actualiza el nombre de la ruta.
      nombreRutaActual = switch (rutas) {
        // TODO(ANYONE): Arreglar nombre de ruta para KYC
        RutaInicio.name => l10n.pageHomeTitleAppBar,
        RutaLogin.name => l10n.loginPageTitleAppBar,
        RutaInasistencia.name => l10n.absencePageTitleAppBar,
        RutaComunidadAcademica.name => l10n.commonAcademicCommunity,
        _ => '',
      };
    });
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
                        Scaffold.of(context).openDrawer();
                      },
                    );
              },
            ),
            title: Center(
              child: Text(
                nombreRutaActual,
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
