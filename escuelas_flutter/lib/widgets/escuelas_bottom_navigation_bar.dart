import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

// TODO(anyone): Mejorar el routeo y hacerlo con switch, tambien mejorar el
// tema del index

/// {@template EscuelasBottomNavigationBar}
/// Componente de navegacion estatico
/// {@endtemplate}
class EscuelasBottomNavigationBar extends StatelessWidget {
  /// {@macro EscuelasBottomNavigationBar}
  const EscuelasBottomNavigationBar({
    required this.index,
    super.key,
  });

  /// Index para saber que icono colorear
  final int index;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 55.ph,
      margin: EdgeInsets.symmetric(
        horizontal: 15.pw,
        vertical: 15.ph,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.sw),
        color: colores.tertiary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ItemBottomNavigationBar(
            icono: Icons.house_outlined,
            estaSeleccionado: index == 0,
            onTap: () => context.pushRoute(RutaInicio()),
          ),
          _ItemBottomNavigationBar(
            icono: Icons.description_outlined,
            estaSeleccionado: index == 1,
            onTap: () {},
          ),
          _ItemBottomNavigationBar(
            icono: Icons.person_2_outlined,
            estaSeleccionado: index == 2,
            onTap: () => context.pushRoute(
              RutaPerfilUsuarioPendiente(
                idUsuarioPendiente: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template _ItemBottomNavigationBar}
/// Componente item de la barra de navegacion
/// {@endtemplate}
class _ItemBottomNavigationBar extends StatelessWidget {
  /// {@macro _ItemBottomNavigationBar}
  const _ItemBottomNavigationBar({
    required this.onTap,
    required this.estaSeleccionado,
    required this.icono,
  });

  /// Icono a mostrar en el componente
  final IconData icono;

  /// Indica si el icono esta seleccionado
  final bool estaSeleccionado;

  /// Funcion al presionar el icono
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icono,
        color: estaSeleccionado ? colores.onBackground : colores.secondary,
      ),
    );
  }
}
