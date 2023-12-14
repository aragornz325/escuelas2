import 'package:flutter/material.dart';

/// {@template EscuelasScaffold}
/// Scaffold General que se va a utilizar en el proyecto escuelas para los
/// Callback de las pantallas de la app.
/// {@endtemplate}
class EscuelasScaffold extends StatefulWidget {
  /// {@macro EscuelasScaffold}
  const EscuelasScaffold({
    required this.cuerpo,
    this.colorDeFondo,
    super.key,
  });

  /// Componente a dibujar.
  final Widget cuerpo;

  /// Color de fondo,por defecto va a tener el color de background del theme.
  final Color? colorDeFondo;

  @override
  State<EscuelasScaffold> createState() => _EscuelasScaffoldState();
}

class _EscuelasScaffoldState extends State<EscuelasScaffold> {
  @override
  void initState() {
    // ? Estos callbacks se podrían instanciar en otro lado que no sea
    // ? en el initState del scaffold, se supone que las variables
    // ? globales en dart son malas prácticas, pero fue la unica manera
    // ? que lo logramos hacer andar
    // TODO(ANYONE): Descomentar cuando haya handleo de errores
    // onErrorCustom = (e) => const EscuelasDialogError().show(context);

    // onDesconocido = (st, e) => const EscuelasDialogError().show(context);

    // onErrorNoEncontrado = (e) =>
    //context.router.push(RutaError(excepcion: e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      backgroundColor:
      
      backgroundColor: widget.colorDeFondo   ?? colores.background,
      body: widget.cuerpo,
    );
  }
}
