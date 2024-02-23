import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/calcular_color_segun_calificacion.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ElementoLista}
/// Componente reutilizable usado en listas generalmente que permite presionarlo
/// para ejecutar determinada accion.
/// {@endtemplate}
class ElementoLista extends StatelessWidget {
  /// {@macro ElementoLista}
  const ElementoLista({
    required this.texto,
    this.colorFondo,
    this.tieneBoxShadow = false,
    this.estaHabilitado = true,
    this.onTap,
    this.padding,
    this.altura,
    this.ancho,
    this.borderRadius = 20,
    this.widgetLateralDerecho,
    this.widgetLateralIzquierdo,
    this.tieneBordeVisible = false,
    super.key,
  });

  factory ElementoLista.misCursos({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre de la materia.
    required String nombreMateria,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Indica si esta habilitado para presionarse o no
    required bool estaHabilitado,

    /// Indica si las calificaciones de esa materia ya fueron cargas en el mes
    required bool estaCargada,
  }) {
    final colores = context.colores;

    return ElementoLista(
      altura: 50.ph,
      texto: Text(
        nombreMateria.toUpperCase(),
        maxLines: 1,
        style: TextStyle(
          fontSize: 12.pf,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w700,
          color: estaHabilitado
              ? colores.onBackground
              : colores.onBackground.withOpacity(.3),
        ),
      ),
      colorFondo: colores.tertiary,
      onTap: onTap,
      widgetLateralDerecho: Padding(
        padding: EdgeInsets.only(right: 10.pw),
        child: estaHabilitado && !estaCargada
            ? Icon(
                Icons.circle,
                color: colores.error,
                size: 15.sw,
              )
            : Icon(
                Icons.check_circle,
                color: estaHabilitado && estaCargada
                    ? colores.verdeConfirmar
                    : colores.secondary,
                size: 15.sw,
              ),
      ),
    );
  }

  /// Elemento para la lista de usuarios en Comunidad Academica
  factory ElementoLista.usuarioComunidadAcademica({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre del rol.
    required String nombreUsuario,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Avatar del usuario
    required String avatar,

    /// Indica por que dato se va a ordenar
    required OrdenarPor ordenarPor,

    /// Usuario al que se le va a usar la data
    required Usuario usuario,
  }) {
    final colores = context.colores;

    /// Ordena por curso, asignatura
    String funcionOrdenarPor() {
      var etiqueta = '';

      switch (ordenarPor) {
        case OrdenarPor.curso:
          if (usuario.asignaturas?.isNotEmpty ?? false) {
            final asignaturas = usuario.asignaturas
                    ?.map((e) => e.asignatura?.nombre ?? '')
                    .toList() ??
                [];

            etiqueta = asignaturas.join(', ');
          }
        case OrdenarPor.asignatura:
          if (usuario.comisiones?.isNotEmpty ?? false) {
            final cursos = usuario.asignaturas
                    ?.map((e) => e.asignatura?.nombre ?? '')
                    .toList() ??
                [];

            etiqueta = cursos.join(', ');
          }

        case OrdenarPor.apellido:
      }
      return etiqueta;
    }

    return ElementoLista(
      altura: 55.ph,
      texto: Text(
        nombreUsuario,
        style: TextStyle(
          fontSize: 14.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
      borderRadius: 40.sw,
      colorFondo: colores.tertiary,
      onTap: onTap,
      widgetLateralIzquierdo: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(35.sw)),
        child: Image.network(
          avatar,
          fit: BoxFit.cover,
          height: 35.sh,
          width: 35.sw,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) =>
              Image.asset(
            Assets.images.usuario.path,
            color: colores.onBackground,
            fit: BoxFit.cover,
            height: 35.sh,
            width: 35.sw,
          ),
        ),
      ),
      widgetLateralDerecho: Padding(
        padding: EdgeInsets.only(right: 10.pw),
        child: Text(
          funcionOrdenarPor(),
          style: TextStyle(
            fontSize: 10.pf,
            color: colores.onSecondary,
          ),
        ),
      ),
    );
  }

  factory ElementoLista.usuario({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre del rol.
    required String nombreUsuario,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Avatar del usuario
    required String avatar,
  }) {
    final colores = context.colores;

    return ElementoLista(
      altura: 55.ph,
      texto: Text(
        nombreUsuario,
        style: TextStyle(
          fontSize: 14.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
      borderRadius: 40.sw,
      colorFondo: colores.tertiary,
      onTap: onTap,
      widgetLateralIzquierdo: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(35.sw)),
        child: Image.network(
          avatar,
          fit: BoxFit.cover,
          height: 35.sh,
          width: 35.sw,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) =>
              Image.asset(
            Assets.images.usuario.path,
            color: colores.onBackground,
          ),
        ),
      ),
    );
  }

  /// Elemento de lista para la supervision de cursos
  factory ElementoLista.supervisionComision({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre del curso.
    required String nombreComision,

    /// Color del fondo del elemento
    required Color colorFondo,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Componente que se agrega al final del [ElementoLista] a la derecha
    required Widget widgetLateralDerecho,
  }) {
    final colores = context.colores;
    return ElementoLista(
      texto: Text(
        nombreComision.toUpperCase(),
        style: TextStyle(
          fontSize: 16.pf,
          fontWeight: FontWeight.w700,
          color: colores.background,
        ),
      ),
      altura: 55.ph,
      ancho: 340.pw,
      borderRadius: 40.sw,
      colorFondo: colorFondo,
      onTap: onTap,
      widgetLateralDerecho: widgetLateralDerecho,
    );
  }

  /// Elemento de lista para la pantalla inicial
  factory ElementoLista.menu({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre de la opcion.
    required String nombreOpcion,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Indica si esta presionado o no
    bool estaPresionado = false,

    /// Componente que se agrega al final del [ElementoLista] a la derecha
    Widget? widgetLateralDerecho,
  }) {
    final colores = context.colores;

    return ElementoLista(
      tieneBoxShadow: estaPresionado,
      altura: 65.ph,
      padding: EdgeInsets.only(left: 20.pw),
      texto: Text(
        nombreOpcion.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16.pf,
          color: colores.onBackground,
        ),
      ),
      colorFondo: colores.tertiary,
      onTap: onTap,
      widgetLateralDerecho: widgetLateralDerecho,
    );
  }

  /// Elemento de lista para la lista de cursos en inasistencia
  factory ElementoLista.inasistencia({
    /// Nombre del [ElementoLista]
    required String nombre,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Boton para cambiar la inasistencia entre 1/4, 1/2, presente y ausente
    required Widget botonCambioInasistencia,

    /// Foto de perfil del usuario
    required Widget fotoPerfil,

    /// Ancho del elemento
    double? ancho,
  }) {
    final colores = context.colores;

    return ElementoLista(
      colorFondo: colores.transparente,
      ancho: ancho ?? 300.pw,
      altura: 50.ph,
      borderRadius: 50.sw,
      texto: Text(
        nombre,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: colores.onBackground,
          fontWeight: FontWeight.w400,
          fontSize: 15.pf,
        ),
      ),
      widgetLateralDerecho: botonCambioInasistencia,
      widgetLateralIzquierdo: fotoPerfil,
    );
  }

  /// Elemento de lista para la lista de cursos en supervision de envio de
  /// calificaciones
  factory ElementoLista.supervisionEnvioCalificaciones({
    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Nombre de la materia
    required String nombreAsignatura,

    /// Nombre del profesor de la materia
    required String nombreProfesor,

    /// Fecha de carga de las calificaciones de la asignatura
    required DateTime fechaDeCarga,
  }) {
    final colores = context.colores;

    return ElementoLista(
      altura: 40.ph,
      borderRadius: 50.sw,
      texto: Text(
        '${nombreAsignatura.toUpperCase()} ($nombreProfesor)',
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 13.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
      widgetLateralDerecho: Padding(
        padding: EdgeInsets.only(right: 10.pw),
        child: Text(
          fechaDeCarga.formatear,
          textAlign: TextAlign.center,
          style: TextStyle(
            // TODO: Cambiar color dependiendo de la fecha
            color: Colors.green,
            fontSize: 15.pf,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Elemento de lista para la lista de cursos en supervision de envio de
  /// calificaciones
  factory ElementoLista.kyc({
    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Nombre de la materia
    required String? nombreAsignatura,

    /// Nombre del profesor de la materia
    required String? nombreComision,

    /// Fecha de carga de las calificaciones de la asignatura
    required void Function() onTapWidgetLateralDerecho,
  }) {
    final colores = context.colores;

    final sinGuion = nombreAsignatura == '';

    return ElementoLista(
      altura: 50.ph,
      borderRadius: 50.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      texto: Text(
        sinGuion ? '$nombreComision' : '$nombreAsignatura - $nombreComision',
        style: TextStyle(
          color: colores.onSecondary,
          fontSize: 16.pf,
          fontWeight: FontWeight.w700,
        ),
      ),
      widgetLateralDerecho: Padding(
        padding: EdgeInsets.only(right: 10.pw),
        child: GestureDetector(
          onTap: onTapWidgetLateralDerecho,
          child: Icon(
            Icons.delete_outline_outlined,
            size: 25.pw,
            color: colores.error,
          ),
        ),
      ),
    );
  }

  /// Elemento de lista que muestra el promedio del alumno en la vista
  /// calificaciones anuales
  factory ElementoLista.promedioAlumno({
    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Promedio del alumno
    required double promedio,

    /// Resto de los parámetros que desees incluir
  }) {
    final colores = context.colores;
    final l10n = context.l10n;

    return ElementoLista(
      colorFondo: colores.background,
      tieneBordeVisible: true,
      texto: Text(
        l10n.pageGradesStudentCardAverage,
        style: TextStyle(
          fontSize: 16.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
      ancho: 150.pw,
      altura: 33.ph,
      widgetLateralDerecho: Container(
        height: 33.ph,
        width: 52.pw,
        decoration: BoxDecoration(
          color: getColorFromCalificacion(
            calificacion: promedio,
            context: context,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            '$promedio',
            style: TextStyle(
              fontSize: 15.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  /// Elemento de lista para mostrar un texto y un [String] que dice 'Sin datos'
  factory ElementoLista.sinDatos({
    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Nombre del profesor de la materia
    required String texto,
  }) {
    final colores = context.colores;

    return ElementoLista(
      altura: 50.ph,
      borderRadius: 50.sw,
      texto: Text(
        texto,
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Texto alineado a la izquierda
  final Text texto;

  /// Funcion que se ejecuta al presionar
  final VoidCallback? onTap;

  /// Color del background
  final Color? colorFondo;

  /// Altura
  final double? altura;

  /// Ancho
  final double? ancho;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  /// Radio del borde del [ElementoLista]
  final double borderRadius;

  /// Componente que se agrega al final del [ElementoLista] a la derecha
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralDerecho;

  /// Componente que se agrega al principio del [ElementoLista] a la izquierda
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralIzquierdo;

  /// En caso de ser true agrega box shadow al presionar el elemento.
  final bool tieneBoxShadow;

  /// Espacio entre el contenido y el borde del [ElementoLista]
  final EdgeInsetsGeometry? padding;

  /// Determina si se va a mostrar o no un borde gris alrededor del elemento.
  final bool tieneBordeVisible;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final widgetLateralDerecho = this.widgetLateralDerecho;

    final widgetLateralIzquierdo = this.widgetLateralIzquierdo;

    return GestureDetector(
      onTap: estaHabilitado ? onTap : null,
      child: Container(
        height: altura,
        width: ancho,
        decoration: BoxDecoration(
          color: estaHabilitado
              ? colorFondo ?? colores.tertiary
              : colores.secondary,
          borderRadius: BorderRadius.circular(borderRadius),
          border: tieneBordeVisible
              ? Border.all(
                  color: colores.tooltipBackground,
                )
              : null,
          boxShadow: tieneBoxShadow
              ? [
                  BoxShadow(
                    blurRadius: 50,
                    offset: const Offset(0, -4),
                    color: colores.grisClaroSombreado,
                    inset: true,
                  ),
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                    inset: true,
                    color: colores.grisSC,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: padding ??
                    EdgeInsets.symmetric(
                      vertical: 5.ph,
                    ).copyWith(left: 10.pw),
                child: Row(
                  children: [
                    if (widgetLateralIzquierdo != null) widgetLateralIzquierdo,
                    if (widgetLateralIzquierdo != null) SizedBox(width: 5.pw),
                    Flexible(child: texto),
                  ],
                ),
              ),
            ),
            if (widgetLateralDerecho != null) widgetLateralDerecho,
          ],
        ),
      ),
    );
  }
}
