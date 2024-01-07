import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/appbar/escuelas_appbar.dart';
import 'package:escuelas_flutter/widgets/drawer/escuelas_drawer.dart';
import 'package:escuelas_flutter/widgets/escuelas_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

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

  /// Determina si se muestra el BottomNavBar o no.
  final bool tieneBottomNavBar;

  /// Indice de la ruta seleccionada
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      drawer: const EscuelasDrawer(
        // TODO(SAM): Agregar userInfo
        nombre: 'Carlos',
        apellido: 'Menem',
      ),
      appBar: tieneAppBar ? const EscuelasAppBar() : null,
      backgroundColor: colorDeFondo ?? colores.background,
      body: cuerpo,
      bottomNavigationBar: tieneBottomNavBar
          ? EscuelasBottomNavigationBar(index: index ?? 0)
          : null,
    );
  }
}
