import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowAgregarEliminarPlantilla}
/// Row que contiene el boton para agregar una nueva plantilla y el boton
/// para entrar en modo eliminacion
/// {@endtemplate}
class RowAgregarEliminarPlantilla extends StatefulWidget {
  /// {@macro RowAgregarEliminarPlantilla}
  const RowAgregarEliminarPlantilla({super.key});

  @override
  State<RowAgregarEliminarPlantilla> createState() =>
      _RowAgregarEliminarPlantillaState();
}

class _RowAgregarEliminarPlantillaState
    extends State<RowAgregarEliminarPlantilla> {
  bool modoEliminar = false;

  void onCambioDeModo() {
    setState(() {
      modoEliminar = !modoEliminar;
    });
  }

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

class DesplegablePlantilla extends StatelessWidget {
  const DesplegablePlantilla({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return ExpansionTile(
      backgroundColor: colores.tertiary,
      collapsedBackgroundColor: colores.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sw)),
      title: Text(
        'Plantilla',
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 16.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        DateTime.now().toString(),
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 8.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
