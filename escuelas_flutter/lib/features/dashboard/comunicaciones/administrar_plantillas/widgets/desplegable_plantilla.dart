import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DesplegablePlantilla}
/// Desplegable que muestra los datos de la plantilla
/// {@endtemplate}
class DesplegablePlantilla extends StatefulWidget {
  /// {@macro DesplegablePlantilla}
  const DesplegablePlantilla({
    required this.necesitaSupervision,
    required this.onEditar,
    required this.onCancelarEdicion,
    required this.plantillaConCheckbox,
    super.key,
    this.onChanged,
  });

  /// Verifica si la plantilla necesita supervisión, de ser true, se agrega
  /// el icono de supervisión
  final bool necesitaSupervision;

  /// Accion para cambiar a modo editar o cancelar
  final VoidCallback onEditar;

  /// Accion para cancelar la edicion
  final VoidCallback onCancelarEdicion;

  ///  OnChanged del checkbox de supervision
  final void Function(bool?)? onChanged;

  /// plantilla que otorgara los datos
  final PlantillaConCheckbox plantillaConCheckbox;

  @override
  State<DesplegablePlantilla> createState() => _DesplegablePlantillaState();
}

class _DesplegablePlantillaState extends State<DesplegablePlantilla> {
  bool _estaSeleccionado = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    _estaSeleccionado = widget.plantillaConCheckbox.seleccionado;

    return BlocBuilder<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      builder: (context, state) {
        return ExpansionTile(
          backgroundColor: colores.tertiary,
          collapsedBackgroundColor: colores.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sw),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sw),
          ),
          leading: state.modoEliminar
              ? Checkbox(
                  value: _estaSeleccionado,
                  onChanged: (value) {
                    _estaSeleccionado = value!;

                    context.read<BlocAdministrarPlantillas>().add(
                          BlocAdministrarPlantillasEventoAlternarSeleccionPlantilla(
                            idPlantillaSeleccionada:
                                widget.plantillaConCheckbox.plantilla.id ?? 0,
                          ),
                        );
                  },
                )
              : null,
          title: Row(
            children: [
              SizedBox(
                width: state.modoEliminar ? 180.pw : 220.pw,
                child: Text(
                  widget.plantillaConCheckbox.plantilla.titulo,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (widget.necesitaSupervision)
                Icon(
                  Icons.supervised_user_circle_outlined,
                  color: colores.onBackground,
                  size: 24.sw,
                ),
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
                        '${l10n.pageManageTemplatesCreatedAt} ${widget.plantillaConCheckbox.plantilla.fechaCreacion.formatear}',
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 10.pf,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${l10n.pageManageTemplatesUpdateAt} ${widget.plantillaConCheckbox.plantilla.ultimaModificacion.formatear}',
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 10.pf,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: max(30.ph, 30.sh)),
                  IntrinsicHeight(
                    child: Text(
                      widget.plantillaConCheckbox.plantilla.nota,
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
                  if (widget.necesitaSupervision)
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
      },
    );
  }
}
