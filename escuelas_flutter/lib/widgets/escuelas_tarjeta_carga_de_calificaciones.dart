import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/constantes/textos_valorativos.dart';
import 'package:escuelas_flutter/utilidades/funciones/calcular_promedio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_responsive/full_responsive.dart';

//!!! CUANDO YA HAY CALIFICACION Y SE PUEDE EDITAR, BUSCAR EN LA LISTA DE
//!!!CALIFICACIONES LA CALIFICACION QUE COINCIDA CON EL PERIODO
/// {@template EscuelasCargaDeCalificacionAUnAlumno}
/// Componente con un sector donde se puede ver el nombre, promedio y texto
/// valorativo del alumno, con la funcion de agregar una calificacion mas.
/// {@endtemplate}
class EscuelasCargaCalificacionAlumno extends StatefulWidget {
  /// {@macro EscuelasCargaDeCalificacionAUnAlumno}
  const EscuelasCargaCalificacionAlumno({
    required this.listaCalificaciones,
    required this.nombreAlumno,
    this.onChanged,
    this.esEditable = true,
    this.calificacionPrevia,
    super.key,
  });

  /// Nombre del alumno a calificar
  final String nombreAlumno;

  /// Lista de notas del alumno
  final List<double> listaCalificaciones;

  /// Indica si se puede editar la calificacion
  final bool esEditable;

  /// Indica si tiene una calificacion previa para mostrar en el textfield
  /// inicialmente
  final String? calificacionPrevia;

  final void Function(String)? onChanged;

  @override
  State<EscuelasCargaCalificacionAlumno> createState() =>
      _EscuelasCargaCalificacionAlumnoState();
}

class _EscuelasCargaCalificacionAlumnoState
    extends State<EscuelasCargaCalificacionAlumno> {
  /// Controlador de la calificacion.
  final controllerCalificacion = TextEditingController();

  /// Promedio de las notas del alumno.
  late double promedio;

  /// Valor TEA, TEP, TED segun promedio.
  late RITE valorRITE;

  /// Indica si el container esta expandido.
  bool estaExpandido = false;

  /// Calcula el promedio si se ingresa una nueva calificacion.
  void calcularPromedioConNuevaCalificacion() {
    final nuevaCalificacion = controllerCalificacion.text.isNotEmpty &&
            controllerCalificacion.text != ''
        ? double.tryParse(controllerCalificacion.text)
        : 0.0;
    promedio = calcularPromedio(widget.listaCalificaciones, nuevaCalificacion);
    valorRITE = devolverRITE(promedio);
    setState(() {});
  }

  @override
  void initState() {
    if (widget.calificacionPrevia != null) {
      controllerCalificacion.text = widget.calificacionPrevia!;
    }
    promedio = calcularPromedio(widget.listaCalificaciones);

    valorRITE = devolverRITE(promedio);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.sw)),
              color: colores.marfilBackgroundDesktop,
            ),
            child: ExpansionTile(
              initiallyExpanded: estaExpandido,
              title: Text(
                widget.nombreAlumno,
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
              onExpansionChanged: (value) => setState(() {
                estaExpandido = value;
              }),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.pageGradesStudentCardAverage,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 13.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    promedio.toStringAsFixed(2),
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 13.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 5.pw),
                  Text(
                    valorRITE.siglas,
                    style: TextStyle(
                      fontSize: 13.pf,
                      color: valorRITE.colorSegunRITE(context),
                    ),
                  ),
                  Icon(
                    estaExpandido
                        ? Icons.arrow_drop_up_rounded
                        : Icons.arrow_drop_down_rounded,
                    color: colores.grisSC,
                    size: 25.pw,
                  ),
                ],
              ),
              backgroundColor: colores.marfilBackgroundDesktop,
              children: <Widget>[
                Divider(
                  height: .1,
                  color: colores.grisSC,
                ),
                ListTile(
                  title: Text(
                    valorRITE.valorativoSegunRITE(),
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 10.pf,
                      fontWeight: FontWeight.w400,
                    ),
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
          ),
        ),
        Container(
          width: 40.sw,
          height: 40.sh,
          margin: EdgeInsets.symmetric(horizontal: 10.pw),
          decoration: BoxDecoration(
            color: controllerCalificacion.text.isEmpty
                ? colores.tertiary
                : colores.azul,
            borderRadius: BorderRadius.circular(100.sw),
          ),

          // TODO(ANYONE): Debe ser un dropdown y consumir ENUM (recibe index) de commons.
          child: TextFormField(
            //     initialValue:      ManejadorDeCalificaciones.obtenerValorDeCalificacion(
            //   state.calificacionesMensuales
            //       .calificacionesMensuales[0].calificacion!.tipoCalificacion,
            //   state.calificacionesMensuales
            //       .calificacionesMensuales[0].calificacion!.index,
            // ),
            readOnly: !widget.esEditable,
            cursorColor: Colors.white,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^([0-9]|10)$')),
              FilteringTextInputFormatter.deny(RegExp(r'[^\d]')),
              LengthLimitingTextInputFormatter(2),
            ],
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            controller: controllerCalificacion,
            onChanged: (value) {
              calcularPromedioConNuevaCalificacion();
              widget.onChanged?.call(value);
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 20.pf,
              color: colores.onPrimary,
              height: 1.7.sh,
            ),
            decoration: InputDecoration(
              hintText: 'S/C',
              // TODO(ANYONE): Ver que poner en el l10n
              hintStyle: TextStyle(
                fontSize: 18.pf,
                color: colores.grisSC,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
