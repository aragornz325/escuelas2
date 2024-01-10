import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';

import 'package:escuelas_flutter/widgets/drawer/bloc/bloc_drawer.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template  EscuelasDrawer}
/// Drawer donde el usuario puede ver su perfil o desloguearse.
/// {@endtemplate}
class EscuelasDrawer extends StatelessWidget {
  /// {@macro EscuelasDrawer}
  const EscuelasDrawer({
    required this.nombreCompleto,
    this.urlImage,
    super.key,
  });
  final String nombreCompleto;

  /// Imagen de appbar[EscuelasDrawer].
  final String? urlImage;

// TODO(SAM): Agregar inkwell/ highlight al presionar boton y mejorar dialog de feat not available

  /// Navega a la ruta del perfil del usuario y luego cierra la pantalla actual
  void _redireccionPerfil(BuildContext context) {
    context.replaceRoute(
      RutaPerfilUsuario(
        idUsuario: 0,
      ),
    );
    Navigator.pop(context);
    // TODO(Anyone): Agregar ID usuario del estado o de sessionMan
  }

  /// Navega a la ruta inicio y cierra el drawer.
  void _redireccionHome(BuildContext context) {
    context.replaceRoute(
      const RutaInicio(),
    );
    Navigator.pop(context);
  }

  /// Muestra dialog para permitirle al usuario cerrar sesion.
  Future<void> _showDialogCerrarSesion(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDrawer>(),
        child: BlocListener<BlocDrawer, BlocDrawerEstado>(
          listener: (context, state) {
            if (state is BlocDrawerEstadoCerrarSesionExitoso) {}

            Navigator.pop(context);
            context.replaceRoute(const RutaLogin());
          },
          child: EscuelasDialog.logOut(
            context: context,
            onCerrarSesion: () {
              context.read<BlocDrawer>().add(BlocDrawerEventoCerrarSesion());
            },
          ),
        ),
      ),
    );
  }

  /// Muestra un alert dialog indicando al usuario que esta feature
  /// no esta disponible.
  Future<void> _showFeatNoDisponible(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.featNoDisponible(
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    return Drawer(
      backgroundColor: colores.transparente,
      shadowColor: colores.onSecondaryOpacidadTreinta,
      child: Stack(
        children: [
          Container(
            color: colores.background,
            width: 265.pw,
            child: Row(
              children: [
                VerticalDivider(
                  color: colores.primaryContainer,
                  thickness: 30.pw,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 60.ph),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 80.sh,
                            width: 80.sw,
                            color: colores.background,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.sw)),
                              child: (urlImage != null && urlImage != '')
                                  ? Image.network(
                                      urlImage!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) =>
                                          Image.asset(
                                        Assets.images.usuario.path,
                                        color: colores.onBackground,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      color: colores.onBackground,
                                      size: 30.sw,
                                    ),
                            ),
                          ),
                          SizedBox(height: 5.ph),
                          SizedBox(
                            width: 200.pw,
                            child: Center(
                              child: Text(
                                nombreCompleto.capitalize,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colores.primaryContainer,
                                  fontSize: 20.pf,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.ph),
                      _EscuelasListTile(
                        icon: Icons.cottage_outlined,
                        title: l10n.pageHomeTitleAppBar,
                        onTap: () => _redireccionHome(context),
                      ),
                      _EscuelasListTile(
                        icon: Icons.settings_outlined,
                        title: l10n.drawerSettings,
                        onTap: () {
                          _showFeatNoDisponible(context);
                        },
                      ),
                      _EscuelasListTile(
                        icon: Icons.person_outline,
                        title: l10n.drawerMyProfile,
                        onTap: () => _redireccionPerfil(context),
                      ),
                      const Spacer(),
                      _EscuelasListTile(
                        icon: Icons.logout,
                        title: l10n.drawerLogOut,
                        onTap: () => _showDialogCerrarSesion(context),
                      ),
                      SizedBox(height: 50.ph),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.pw,
            right: 0.pw,
            child: GestureDetector(
              child: Container(
                width: 60.pw,
                height: 60.ph,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colores.primaryContainer,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: colores.background,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO(ANYONE): Agregar enum para opciones de navegacion en el caso de que
// haya mas?

/// {@template  EscuelasDrawer}
/// List tile del drawer custom, permite pasarle icono, texto y funcion.
/// {@endtemplate}
class _EscuelasListTile extends StatelessWidget {
  /// {@macro EscuelasDrawer}
  const _EscuelasListTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 20.pw),
        child: Icon(
          icon,
          color: colores.primaryContainer,
          size: 34.pw,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.pf,
        ),
      ),
      onTap: onTap,
    );
  }
}
