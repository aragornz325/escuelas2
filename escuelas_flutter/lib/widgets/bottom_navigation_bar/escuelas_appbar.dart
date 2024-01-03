import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template EscuelasAppBar}
/// Componente de navegacion estatico en conjunto con EscuelasDrawer
/// {@endtemplate}
class EscuelasBottomNavigationBar extends StatelessWidget {
  /// {@macro EscuelasAppBar}
  const EscuelasBottomNavigationBar({
    required this.index,
    super.key,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 25.ph,
      margin: EdgeInsets.symmetric(horizontal: 15.pw, vertical: 10.ph),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colores.tertiary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => context.pushRoute(RutaInicio()),
            child: Container(
              height: 20.ph,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.house_outlined,
                color: index == 0 ? colores.onBackground : colores.secondary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 20.ph,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.description_outlined,
                color: index == 1 ? colores.onBackground : colores.secondary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.pushRoute(
              RutaPerfilUsuario(
                idUsuario: 0,
              ),
            ),
            child: Container(
              height: 20.ph,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.person_2_outlined,
                color: index == 2 ? colores.onBackground : colores.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
