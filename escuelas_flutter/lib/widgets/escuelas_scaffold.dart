import 'package:escuelas_flutter/bootstrap.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/user_info.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/appbar/escuelas_appbar.dart';
import 'package:escuelas_flutter/widgets/drawer/escuelas_drawer.dart';
import 'package:escuelas_flutter/widgets/escuelas_bottom_navigation_bar.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shorebird_update_checker/src/widgets/update_dialog_dipatcher.dart';

/// {@template EscuelasScaffold}
/// Scaffold General que se va a utilizar en el proyecto escuelas para los
/// Callback de las pantallas de la app.
/// {@endtemplate}
class EscuelasScaffold extends StatelessWidget {
  /// {@macro EscuelasScaffold}
  const EscuelasScaffold({
    required this.cuerpo,
    this.index,
    this.colorDeFondo,
    this.tieneDrawer = true,
    this.tieneAppBar = false,
    this.tieneBottomNavBar = false,
    super.key,
  });

  /// Componente a dibujar.
  final Widget cuerpo;

  /// Color de fondo, por defecto va a tener el color de background del theme.
  final Color? colorDeFondo;

  /// Determina si se muestra el AppBar o no.
  final bool tieneAppBar;

  /// Determina si se muestra el drawer o no.
  final bool tieneDrawer;

  /// Determina si se muestra el BottomNavBar o no.
  final bool tieneBottomNavBar;

  /// Indice de la ruta seleccionada
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final userInfo = sessionManager.signedInUser;

    return UpdateDialogDispatcher(
      controller: updateController,
      updateDialogTrigger: (int currentPatchNumber, int newPatchNumber) async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return EscuelasDialog.confirmar(
              onTapConfirmar: () async {
                await updateController.updateShorebird();
              },
              content: Text(
                  'Nueva actualización disponible ($currentPatchNumber -> $newPatchNumber)'),
            );
          },
        );
        return false;
      },
      child: Scaffold(
        drawer: EscuelasDrawer(
          urlImage: userInfo?.imageUrl ?? '',
          nombre: userInfo?.userName ?? '',
          apellido: userInfo?.apellido ?? '',
        ),
        // resizeToAvoidBottomInset: true,
        appBar: tieneAppBar
            ? EscuelasAppBar(
                tieneDrawer: tieneDrawer,
              )
            : null,
        backgroundColor: colorDeFondo ?? colores.background,
        body: updateController.shorebirdIsNewPatchAvailableForDownload
            ? Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Nueva actualización disponible',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 50),
                  EscuelasBoton.textoEIcono(
                      color: Colors.green,
                      onTap: () => updateController.updateShorebird(),
                      texto: 'Cerrar app (para instalar actualización)',
                      context: context,
                      icono: Icons.refresh)
                ]),
              )
            : cuerpo,
        bottomNavigationBar: tieneBottomNavBar
            ? EscuelasBottomNavigationBar(index: index ?? 0)
            : null,
      ),
    );
  }
}
