import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

///{@template ItemMateria}
/// Datos del usuario pendiente
/// {@endtemplate}
class ItemMateria extends StatelessWidget {
  /// {@macro ItemMateria}
  const ItemMateria({
    required this.materia,
    required this.onTap,
    required this.estaCargada,
    required this.estaHabilitado,
    super.key,
  });

  /// Usuario del que se muestran los datos
  final Materia materia;

  /// On tap del item
  final VoidCallback onTap;

  /// Indica si las calificaciones de esa materia ya fueron cargas en el mes
  /// seleccionado
  final bool estaCargada;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      children: [
        Expanded(
          child: ElementoLista.materia(
            nombreMateria: materia.nombre,
            estaCargada: estaCargada,
            estaHabilitado: estaHabilitado,
            context: context,
            // TODO(anyone): Poner la funcion
            onTap: () {},
          ),
        ),
        SizedBox(width: 10.pw),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.sw),
              color: estaHabilitado
                  ? colores.primaryContainer
                  : colores.primaryContainer.withOpacity(.3),
            ),
            width: 35.sw,
            height: 35.sh,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: colores.background,
                size: 12.sw,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
