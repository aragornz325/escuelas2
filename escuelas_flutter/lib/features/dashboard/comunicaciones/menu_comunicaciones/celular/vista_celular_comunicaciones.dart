import 'package:escuelas_flutter/features/dashboard/comunicaciones/widgets/menu_opciones_comunicacion.dart';
import 'package:flutter/material.dart';

/// {@template PaginaMenuComunicaciones}
/// Vista celular de MenuComunicaciones donde un directivo verificar
/// las comunicaciones en general.
/// {@endtemplate}
class VistaCelularMenuComunicaciones extends StatelessWidget {
  /// {@macro PaginaMenuComunicaciones}
  const VistaCelularMenuComunicaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuOpcionesDeComunicaciones();
  }
}
