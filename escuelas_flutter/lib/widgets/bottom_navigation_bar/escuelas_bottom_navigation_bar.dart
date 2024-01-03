import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

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
          GestureDetector(
            onTap: () => context.pushRoute(RutaInicio()),
            child: Icon(
              Icons.house_outlined,
              color: index == 0 ? colores.onBackground : colores.secondary,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.description_outlined,
              color: index == 1 ? colores.onBackground : colores.secondary,
            ),
          ),
          GestureDetector(
            onTap: () => context.pushRoute(
              // TODO(Gon): Pasar id del usuario logeado
              RutaPerfilUsuario(
                idUsuario: 0,
              ),
            ),
            child: Icon(
              Icons.person_2_outlined,
              color: index == 2 ? colores.onBackground : colores.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
