import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/lista_comunicaciones_pendientes.dart';
import 'package:flutter/material.dart';

/// {@template VistaCelularComunicacionesPendientes}
/// Vista de celular de comunicaciones pendientes.
/// en comisiones.
/// {@endtemplate}
class VistaCelularComunicacionesPendientes extends StatefulWidget {
  /// {@macro VistaCelularComunicacionesPendientes}
  const VistaCelularComunicacionesPendientes({super.key});

  @override
  State<VistaCelularComunicacionesPendientes> createState() =>
      _VistaCelularComunicacionesPendientesState();
}

class _VistaCelularComunicacionesPendientesState
    extends State<VistaCelularComunicacionesPendientes> {
  @override
  Widget build(BuildContext context) {
    return const ListaComunicacionesPendientes();
  }
}
