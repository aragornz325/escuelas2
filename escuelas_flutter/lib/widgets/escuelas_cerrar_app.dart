import 'dart:async';

import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:flutter/material.dart';

/// {@template EscuelasConfirmarCerrarApp}
/// Widget para preguntar si quiere cerrar la app.
/// {@endtemplate}
class EscuelasConfirmarCerrarApp extends StatefulWidget {
  /// {@macro EscuelasConfirmarCerrarApp}
  const EscuelasConfirmarCerrarApp({
    required this.child,
    super.key,
  });

  /// Widget a preguntar si quiere cerrar la app.
  final Widget child;

  @override
  State<EscuelasConfirmarCerrarApp> createState() =>
      _EscuelasConfirmarCerrarAppState();
}

class _EscuelasConfirmarCerrarAppState
    extends State<EscuelasConfirmarCerrarApp> {
  /// Indica si debe cerrar la app.
  bool _quiereCerrarApp = false;

  /// Cuando apreto para salir de la app.
  DateTime cuandoPresiono = DateTime.now();

  /// Controla el tiempo en el que se muestra el toast
  late Timer _toastDelTiempo;

  /// Funcion para cerrar la app.
  void _cerrarApp() {
    final l10n = context.l10n;
    final now = DateTime.now();

    if (now.difference(cuandoPresiono) > const Duration(seconds: 2)) {
      cuandoPresiono = now;

      showEcuelasToast(
        mensaje: l10n.commonConfirmCloseApp,
        context: context,
      );
      _toastDelTiempo = Timer(
        const Duration(seconds: 2),
        () => setState(() => _quiereCerrarApp = false),
      );
    }
    setState(() => _quiereCerrarApp = true);
  }

  @override
  void initState() {
    _toastDelTiempo = Timer(Duration.zero, () {});
    super.initState();
  }

  @override
  void dispose() {
    _toastDelTiempo.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _quiereCerrarApp,
      onPopInvoked: (v) => _cerrarApp(),
      child: widget.child,
    );
  }
}
