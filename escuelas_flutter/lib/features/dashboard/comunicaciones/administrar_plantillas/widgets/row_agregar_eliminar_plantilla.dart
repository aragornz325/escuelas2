import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowAgregarEliminarPlantilla}
/// Row que contiene el boton para agregar una nueva plantilla y el boton
/// para entrar en modo eliminacion
/// {@endtemplate}
class RowAgregarEliminarPlantilla extends StatelessWidget {
  /// {@macro RowAgregarEliminarPlantilla}
  const RowAgregarEliminarPlantilla({
    required this.onCambioDeModo,
    this.modoEliminar = false,
    super.key,
  });

  final bool modoEliminar;

  final VoidCallback onCambioDeModo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BotonAgregarPlantilla(),
          RowModoEliminar(
            onEliminar: () {},
            modoEliminar: modoEliminar,
            onCambioDeModo: onCambioDeModo,
          ),
        ],
      ),
    );
  }
}

/// {@template BotonAgregarPlantilla}
/// Boton para agregar una nueva plantilla
/// {@endtemplate}
class BotonAgregarPlantilla extends StatelessWidget {
  /// {@macro BotonAgregarPlantilla}
  const BotonAgregarPlantilla({super.key});
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.pageManageTemplatesAddNew,
          style: TextStyle(
            color: colores.primary,
            fontSize: 16.pf,
          ),
        ),
        Icon(
          Icons.add,
          color: colores.primary,
          size: 25.sw,
        ),
      ],
    );
  }
}

/// {@template RowModoEliminar}
/// Row que contiene el boton para cancelar el modo eliminar y el boton
/// para eliminar las plantillas seleccionadas
/// {@endtemplate}
class RowModoEliminar extends StatelessWidget {
  /// {@macro RowModoEliminar}
  const RowModoEliminar({
    required this.modoEliminar,
    required this.onEliminar,
    required this.onCambioDeModo,
    super.key,
  });

  /// Determina la composicion del componente
  final bool modoEliminar;

  /// Accion para cambiar a modo eliminar o cancelar
  final VoidCallback onCambioDeModo;

  /// Accion para eliminar las plantillas
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return modoEliminar
        ? Row(
            children: [
              InkWell(
                onTap: onCambioDeModo,
                child: Text(
                  l10n.commonCancel,
                  style: TextStyle(
                    color: colores.error,
                    fontSize: 14.pf,
                  ),
                ),
              ),
              SizedBox(width: 8.sw),
              GestureDetector(
                onTap: onEliminar,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sw),
                    ),
                    color: colores.error,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .1,
                        blurRadius: 2,
                        offset: const Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.pw, vertical: 2.ph),
                    child: Text(
                      l10n.commonDelete,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.pf,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : InkWell(
            onTap: onCambioDeModo,
            child: Icon(
              Icons.delete_outline,
              color: colores.error,
              size: 24.sw,
            ),
          );
  }
}

/// {@template DesplegablePlantilla}
/// Desplegable que muestra los datos de la plantilla
/// {@endtemplate}
class DesplegablePlantilla extends StatelessWidget {
  /// {@macro DesplegablePlantilla}
  const DesplegablePlantilla({
    required this.necesitaSupervision,
    required this.modoEliminar,
    super.key,
  });

  /// Verifica si la plantilla necesita supervisión, de ser true, se agrega
  /// el icono de supervisión
  final bool necesitaSupervision;

  /// Verifica si se encuentra en modoEliminar, de ser true, se agrega el
  /// checkbox para seleccionar la plantilla
  final bool modoEliminar;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return ExpansionTile(
      backgroundColor: colores.tertiary,
      collapsedBackgroundColor: colores.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      leading: modoEliminar
          ? Icon(
              Icons.check_circle_outline,
              color: colores.error,
            )
          : null,
      title: Row(
        children: [
          Text(
            'Plantilla',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colores.onBackground,
              fontSize: 16.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (necesitaSupervision)
            Icon(
              Icons.supervised_user_circle_outlined,
              color: colores.onBackground,
              size: 24.sw,
            ),
          IconButton(
            //!TODO(Manu): Dar funcion
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              color: colores.onBackground,
            ),
          ),
        ],
      ),
      childrenPadding: EdgeInsets.symmetric(vertical: max(10.ph, 10.sh)),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.pw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fecha de creacion: 10/12}',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 8.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'ultima edicion: 27/12}',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 8.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.pw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Necesita supervicion'),
              if (necesitaSupervision)
                Icon(
                  Icons.check_box_sharp,
                  color: colores.primary,
                )
              else
                Icon(
                  Icons.check_box_outline_blank_outlined,
                  color: colores.primary,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
