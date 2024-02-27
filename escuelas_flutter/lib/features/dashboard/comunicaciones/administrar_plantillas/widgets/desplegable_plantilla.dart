import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
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
    required this.onModoEliminar,
    required this.onModoEditar,
    required this.onEditar,
    required this.onCancelarEdicion,
    required this.estaSeleccionada,
    required this.plantilla,
    super.key,
    this.onChanged,
    // this.onChangedEliminar,
  });

  /// Verifica si la plantilla necesita supervisión, de ser true, se agrega
  /// el icono de supervisión
  final bool necesitaSupervision;

  /// Verifica si se encuentra en modoEliminar, de ser true, se agrega el
  /// checkbox para seleccionar la plantilla
  final bool onModoEliminar;

  /// Verifica si se encuentra en modo editar
  final bool onModoEditar;

  /// Accion para cambiar a modo editar o cancelar
  final VoidCallback onEditar;

  /// Accion para cancelar la edicion
  final VoidCallback onCancelarEdicion;

  ///  OnChanged del checkbox de supervision
  final void Function(bool?)? onChanged;

  /// plantilla que otorgara los datos
  final PlantillaComunicacion plantilla;

  final bool estaSeleccionada;

  @override
  State<DesplegablePlantilla> createState() => _DesplegablePlantillaState();
}

class _DesplegablePlantillaState extends State<DesplegablePlantilla> {
  late TextEditingController controllerTitulo;
  late TextEditingController controllerDescripcion;
  late bool _estaSeleccionado;

  @override
  void initState() {
    controllerTitulo = TextEditingController(text: widget.plantilla.titulo);
    controllerDescripcion = TextEditingController(text: widget.plantilla.nota);
    _estaSeleccionado = widget.estaSeleccionada;

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
          ? Checkbox(
              value: _estaSeleccionado,
              onChanged: (value) {
                _estaSeleccionado = value!;
                if (_estaSeleccionado == true) {
                  context.read<BlocAdministrarPlantillas>().add(
                        BlocAdministrarPlantillasEventoPlantillaSeleccionada(
                          plantillaSeleccionada: widget.plantilla,
                          select: true,
                        ),
                      );
                }
                if (_estaSeleccionado == false) {
                  context.read<BlocAdministrarPlantillas>().add(
                        BlocAdministrarPlantillasEventoPlantillaNoSeleccionada(
                          plantilla: widget.plantilla,
                          select: false,
                        ),
                      );
                }
                setState(() {
                  if (widget.onModoEliminar == false) {
                    _estaSeleccionado = false;
                  }
                });
              },
            )
          : null,
      title: Row(
        children: [
//! TODO(Manu): Verificar si me lo admiten, ya que no pude mantener orden de lista ni hacer que un solo expansiontile entre en modoedicion

          if (widget.onModoEditar)
            EscuelasTextfield(
              maxLines: 1,
              width: 200.pw,
              height: 35.ph,
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
            SizedBox(
              width: widget.onModoEliminar ? 180.pw : 220.pw,
              child: Text(
                widget.plantilla.titulo,
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
                  onPressed: () {
                    context.read<BlocAdministrarPlantillas>().add(
                          BlocAdministrarPlantillasEventoEditarPlantilla(
                            idPlantilla: widget.plantilla.id ?? 0,
                            plantilla: widget.plantilla,
                            nuevoNombre: controllerTitulo.text,
                            nuevaDescripcion: controllerDescripcion.text,
                            nuevaNecesitaSupervision: true,
                          ),
                        );
                  },
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
                    '${l10n.pageManageTemplatesCreatedAt} ${widget.plantilla.fechaCreacion.formatear}',
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 10.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${l10n.pageManageTemplatesUpdateAt} ${widget.plantilla.ultimaModificacion.formatear}',
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
                    widget.plantilla.nota,
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
