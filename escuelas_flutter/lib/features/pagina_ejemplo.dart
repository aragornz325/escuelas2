import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/theming/base.dart';
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
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNDO',
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  habilitacionCargaDeCalificaciones: false,
                  todasMateriasCargadas: false,
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
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNDO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: false,
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
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEGUNTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'TERCERO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'CUARTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'QUINTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
                ),
                SizedBox(
                  height: 5.ph,
                ),
                const ItemCurso(
                  titulo: 'SEXTO',
                  habilitacionCargaDeCalificaciones: true,
                  todasMateriasCargadas: true,
                  fechaUltimaMateriaCargada: '12/12/23',
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
    required this.habilitacionCargaDeCalificaciones,
    required this.todasMateriasCargadas,
    this.fechaUltimaMateriaCargada,
    super.key,
  });

  /// Titulo de curso
  final String titulo;

  /// Indica si los links fueron enviados
  final bool habilitacionCargaDeCalificaciones;

  /// Indica si todas las calificaciones fueron cargadas
  final bool todasMateriasCargadas;

  /// Fecha de la ultima materia del curso a la que se le cargo las
  /// calificaciones
  final String? fechaUltimaMateriaCargada;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return ElementoLista(
      titulo: titulo,
      colorTitulo: Colors.white,
      altura: 45.ph,
      padding: 12.pw,
      colorFondo: todasMateriasCargadas ? colores.azul : colores.onSecondary,
      fontSize: 16.pf,
      fontWeight: FontWeight.w700,
      widgetLateralDerecho: habilitacionCargaDeCalificaciones
          ? Container(
              width: 100.pw,
              height: 45.ph,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.sw)),
                color: habilitacionCargaDeCalificaciones
                    ? todasMateriasCargadas
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
                  todasMateriasCargadas ? fechaUltimaMateriaCargada! : '4/12',
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
                'SIN HABILITAR . 0/12',
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
