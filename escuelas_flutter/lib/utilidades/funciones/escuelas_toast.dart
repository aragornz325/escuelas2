import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template showEcuelasToast}
/// Es una funcion para mostrar un toast customizado para avisar al usuario de
/// cierta acciones.
/// {@endtemplate}
void showEcuelasToast({
  required String mensaje,
  required BuildContext context,
  int duracion = 2,
  ToastGravity? posicionDelToast,
}) {
  final colores = context.colores;

  Fluttertoast.showToast(
    msg: mensaje,
    backgroundColor: colores.secondary,
    timeInSecForIosWeb: duracion,
    fontSize: 18.pf,
    gravity: posicionDelToast ?? ToastGravity.BOTTOM,
  );
}
