import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DesplegablePlantilla}
/// Desplegable que muestra los datos de la plantilla
/// {@endtemplate}
class DesplegablePlantilla extends StatefulWidget {
  /// {@macro DesplegablePlantilla}
  const DesplegablePlantilla({
    required this.necesitaSupervision,
    required this.onModoEliminar,
    required this.fechaCreacion,
    required this.ultimaEdicion,
    required this.descripcionDePlantilla,
    required this.tituloPlantilla,
    required this.onModoEditar,
    required this.onEditar,
    required this.onConfirmarEdicion,
    required this.onCancelarEdicion,
    super.key,
    this.onChanged,
  });

  /// Verifica si la plantilla necesita supervisión, de ser true, se agrega
  /// el icono de supervisión
  final bool necesitaSupervision;

  /// Verifica si se encuentra en modoEliminar, de ser true, se agrega el
  /// checkbox para seleccionar la plantilla
  final bool onModoEliminar;

  /// Verifica si se encuentra en modo editar
  final bool onModoEditar;

  /// Fecha de creacion de la plantilla
  final String fechaCreacion;

  /// Fecha de la ultima edicion
  final String ultimaEdicion;

  /// Descripción de la plantilla
  final String descripcionDePlantilla;

  /// Titulo de la plantilla
  final String tituloPlantilla;

  /// Accion para cambiar a modo editar o cancelar
  final VoidCallback onEditar;

  /// Accion para confirmar la edicion
  final VoidCallback onConfirmarEdicion;

  /// Accion para cancelar la edicion
  final VoidCallback onCancelarEdicion;

  final void Function(bool?)? onChanged;

  @override
  State<DesplegablePlantilla> createState() => _DesplegablePlantillaState();
}

class _DesplegablePlantillaState extends State<DesplegablePlantilla> {
  late TextEditingController controllerTitulo;
  late TextEditingController controllerDescripcion;

  @override
  void initState() {
    controllerTitulo = TextEditingController(text: widget.tituloPlantilla);
    controllerDescripcion =
        TextEditingController(text: widget.descripcionDePlantilla);

    super.initState();
  }

  @override
  void dispose() {
    controllerTitulo.dispose();
    controllerDescripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return ExpansionTile(
      backgroundColor: colores.tertiary,
      collapsedBackgroundColor: colores.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      leading: widget.onModoEliminar
          ? Icon(
              Icons.check_circle_outline,
              color: colores.error,
            )
          : null,
      title: Row(
        children: [
          if (widget.onModoEditar)
            EscuelasTextfield(
              maxLines: 1,
              width: 200.pw,
              height: 35.ph,
              hintText: 'hintText',
              controller: controllerTitulo,
              esPassword: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.pw,
                ),
                border: const OutlineInputBorder(),
              ),
            )
          else
            Text(
              widget.tituloPlantilla,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colores.onBackground,
                fontSize: 16.pf,
                fontWeight: FontWeight.w700,
              ),
            ),
          const Spacer(),
          if (widget.necesitaSupervision)
            Icon(
              Icons.supervised_user_circle_outlined,
              color: colores.onBackground,
              size: 24.sw,
            ),
          if (widget.onModoEditar)
            Row(
              children: [
                IconButton(
                  onPressed: widget.onCancelarEdicion,
                  icon: Icon(
                    Icons.close_rounded,
                    color: colores.onBackground,
                    size: 24.sw,
                  ),
                ),
                IconButton(
                  onPressed: widget.onConfirmarEdicion,
                  icon: Icon(
                    Icons.check_rounded,
                    color: colores.onBackground,
                    size: 24.sw,
                  ),
                ),
              ],
            )
          else
            IconButton(
              onPressed: widget.onEditar,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${l10n.pageManageTemplatesCreatedAt} ${widget.fechaCreacion}',
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 10.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${l10n.pageManageTemplatesUpdateAt} ${widget.ultimaEdicion}',
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 10.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: max(30.ph, 30.sh)),
              if (widget.onModoEditar)
                IntrinsicHeight(
                  child: SizedBox(
                    child: TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.pw,
                          vertical: 5.ph,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.pf),
                      controller: controllerDescripcion,
                    ),
                  ),
                )
              else
                IntrinsicHeight(
                  child: Text(
                    widget.descripcionDePlantilla,
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
              Text(
                l10n.pageManageTemplatesNeedSupervision,
              ),
              if (widget.onModoEditar)
                Checkbox(
                  value: widget.necesitaSupervision,
                  onChanged: widget.onChanged,
                )
              else if (widget.necesitaSupervision)
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
