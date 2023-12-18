import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/utilidades/funciones/colores.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

@RoutePage()
class PaginaEjemplo extends StatelessWidget {
  const PaginaEjemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return FullResponsiveApp(
      child: const Ejemplo(),
    );
  }
}

class Ejemplo extends StatefulWidget {
  const Ejemplo({super.key});

  @override
  State<Ejemplo> createState() => _EjemploState();
}

class _EjemploState extends State<Ejemplo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const ItemCurso(
                  titulo: 'PRIMERO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNDO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  linksEnviados: false,
                  todasCalificacionesEnviadas: false,
                ),
              ],
            ),
            SizedBox(
              height: 50.ph,
            ),
            Column(
              children: [
                const ItemCurso(
                  titulo: 'PRIMERO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNDO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: false,
                ),
              ],
            ),
            SizedBox(
              height: 50.ph,
            ),
            Column(
              children: [
                const ItemCurso(
                  titulo: 'PRIMERO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  linksEnviados: true,
                  todasCalificacionesEnviadas: true,
                  fechaCalificacionesEnviadas: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCurso extends StatelessWidget {
  const ItemCurso({
    required this.titulo,
    required this.linksEnviados,
    required this.todasCalificacionesEnviadas,
    this.fechaCalificacionesEnviadas,
    super.key,
  });

  final String titulo;
  final bool linksEnviados;
  final bool todasCalificacionesEnviadas;
  final String? fechaCalificacionesEnviadas;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return ElementoLista(
      titulo: titulo,
      colorTitulo: Colors.white,
      altura: 45.ph,
      padding: 12.pw,
      colorFondo: todasCalificacionesEnviadas
          ? const Color(0xff6788FF)
          : colores.onSecondary,
      fontSize: 16.pf,
      fontWeight: FontWeight.w700,
      widgetTrasero: linksEnviados
          ? Container(
              width: 100.pw,
              height: 45.ph,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.sw)),
                color: linksEnviados
                    ? todasCalificacionesEnviadas
                        ? Colores(context).segunVencimientoSegunFecha(
                            dia: 9,
                          )
                        : Colores(context).segunProporcionDeMateriasCargadas(
                            proporcion: .4,
                          )
                    : colores.background,
              ),
              child: Center(
                child: Text(
                  todasCalificacionesEnviadas
                      ? fechaCalificacionesEnviadas!
                      : '4/12',
                  style: TextStyle(
                    color: colores.background,
                    fontSize: 15.pf,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(right: 10.pw),
              child: Text(
                'SIN ENVIAR . 0/12',
                style: TextStyle(
                  fontSize: 15.pf,
                  fontWeight: FontWeight.w600,
                  color: colores.onPrimary,
                ),
              ),
            ),
    );
  }
}
