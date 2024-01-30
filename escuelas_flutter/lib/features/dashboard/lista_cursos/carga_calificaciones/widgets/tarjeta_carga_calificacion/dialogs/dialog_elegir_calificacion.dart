import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/manejo_de_calificaciones/manejo_de_calificaciones.dart';
import 'package:escuelas_flutter/utilidades/constantes/textos_valorativos.dart';
import 'package:flutter/material.dart';

/// {@template DialogElegirCalificacion}
/// Dialog para elegir una calificación
/// {@endtemplate}
class DialogElegirCalificacion extends StatelessWidget {
  /// {@macro DialogElegirCalificacion}
  const DialogElegirCalificacion({
    required this.onSelected,
    super.key,
  });

  final void Function(String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15,
        runSpacing: 15,
        children: List.generate(
          10,
          (index) {
            final calificacion =
                ManejadorDeCalificaciones.obtenerValorDeCalificacion(
              TipoCalificacion.numericoDecimal,
              1 + index,
            );

            return GestureDetector(
              onTap: () {
                onSelected(calificacion);
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: devolverRITE(
                  double.parse(calificacion),
                ).colorSegunRITE(context),
                child: Text(
                  calificacion,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
