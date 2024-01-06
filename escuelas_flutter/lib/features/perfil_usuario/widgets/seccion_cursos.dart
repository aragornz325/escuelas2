import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class SeccionCursos extends StatelessWidget {
  const SeccionCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.pw,
        vertical: 14.ph,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.sw)),
        color: colores.marfilBackgroundDesktop,
      ),
      child: ExpansionTile(
        title: Text(
          'CURSOS',
          style: TextStyle(
            color: colores.onBackground,
            fontSize: 13.pf,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sw),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sw),
        ),
        backgroundColor: colores.marfilBackgroundDesktop,
        children: <Widget>[
          Divider(
            height: .5,
            thickness: .5,
            color: colores.grisSC,
          ),
          ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Asignatura',
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Curso',
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.ph),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Matematica',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '4to',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lengua',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '5to',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quimica',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '1ero',
                            style: TextStyle(
                              color: colores.grisSC,
                              fontSize: 14.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sw),
                bottomRight: Radius.circular(20.sw),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
