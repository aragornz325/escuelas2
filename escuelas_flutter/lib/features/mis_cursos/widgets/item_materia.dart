import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

///{@template ItemMateria}
/// Datos del usuario pendiente
/// {@endtemplate}
class ItemMateria extends StatelessWidget {
  /// {@macro ItemMateria}
  const ItemMateria({
    required this.asignatura,
    required this.estaCargada,
    required this.estaHabilitado,
    required this.onTap,
    super.key,
  });

  /// Usuario del que se muestran los datos
  final AsignaturaOverview asignatura;

  /// Indica si las calificaciones de esa materia ya fueron cargas en el mes
  /// seleccionado
  final bool estaCargada;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  /// Funcion que se ejecuta cuando se presiona el boton
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      children: [
        Expanded(
          child: ElementoLista.misCursos(
            nombreMateria: asignatura.nombreDeAsignatura,
            estaCargada: estaCargada,
            estaHabilitado: estaHabilitado,
            context: context,
            // TODO(anyone): Poner la funcion
            onTap: () {},
          ),
        ),
        SizedBox(width: 10.pw),
        GestureDetector(
          onTap: () => estaHabilitado ? onTap : null,
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
                size: 10.sw,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
