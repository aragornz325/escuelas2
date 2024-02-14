import 'package:escuelas_client/escuelas_client.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RadioListTileAsignaturaComision}
/// RadioListTile para el popup de seleccionar una asignatura y quitarla del
/// docente
/// {@endtemplate}
class RadioListTileAsignaturaComision extends StatefulWidget {
  /// {@macro RadioListTileAsignaturaComision}
  const RadioListTileAsignaturaComision({
    required this.asignaturas,
    super.key,
    this.onChanged,
  });

  /// Lista de asignaturas que tiene el usuario
  final List<RelacionAsignaturaUsuario> asignaturas;

  final void Function(RelacionAsignaturaUsuario?)? onChanged;
  @override
  _RadioListTileAsignaturaComisionState createState() =>
      _RadioListTileAsignaturaComisionState();
}

class _RadioListTileAsignaturaComisionState
    extends State<RadioListTileAsignaturaComision> {
  /// Asignatura seleccionada
  RelacionAsignaturaUsuario? selectedAsignatura;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.asignaturas
          .map(
            (relacionAsignaturaUsuario) => RadioListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.trailing,
              title: GrillaAsignaturaComision(
                asignatura: relacionAsignaturaUsuario.asignatura?.nombre ?? '',
                comision: relacionAsignaturaUsuario.comision?.nombre ?? '',
              ),
              value: relacionAsignaturaUsuario,
              groupValue: selectedAsignatura,
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {
                  selectedAsignatura = value;
                });
              },
            ),
          )
          .toList(),
    );
  }
}

/// {@template GrillaAsignaturaComision}
/// Grilla de asignatura y comision utilizada para el popup de quitar asignatura
/// {@endtemplate}
class GrillaAsignaturaComision extends StatelessWidget {
  /// {@macro GrillaAsignaturaComision}
  const GrillaAsignaturaComision({
    required this.asignatura,
    required this.comision,
    super.key,
  });

  /// Refiere al nombre de la asignatura
  final String asignatura;

  /// Refiere a la comision que corresponde la asignatura
  final String comision;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135.pw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(asignatura),
          const Spacer(),
          Text(comision),
          SizedBox(width: 60.pw),
        ],
      ),
    );
  }
}
