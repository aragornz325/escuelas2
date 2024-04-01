import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template EscuelasBoton}
/// Boton personalizado para utilizar
/// {@endtemplate}
class EscuelasBoton extends StatelessWidget {
  /// {@macro EscuelasBoton}
  const EscuelasBoton({
    required this.estaHabilitado,
    required this.onTap,
    required this.color,
    required this.child,
    this.borderRadius,
    this.width,
    this.height,
    this.backgroundColorDeshabilitado,
    this.esOutlined = false,
    this.colorOutline,
    this.widthOutline,
    super.key,
  });

  factory EscuelasBoton.texto({
    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Color del boton.
    required Color color,

    /// Texto interno del boton.
    required String texto,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Tamaño del texto
    double? fontSize,

    /// Ancho del boton, por defecto es 130
    double? width,

    /// Altura del boton, por defecto es 30
    double? height,

    /// Color del boton cuando esta deshabilitado
    Color? backgroundColorDeshabilitado,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      width: width,
      height: height,
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      backgroundColorDeshabilitado: backgroundColorDeshabilitado,
      child: Text(
        texto,
        style: TextStyle(
          fontSize: fontSize ?? 16.pf,
          color: colores.background,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Botom custom que recibe un texto y un icono a eleccion.
  factory EscuelasBoton.textoEIcono({
    /// Color que va a llevar el boton.
    required Color color,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Texto del boton.
    required String texto,

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Icono del boton
    required IconData icono,

    /// Color del texto, por defecto blanco
    Color? colorDeTexto,

    /// Tamaño del texto por defecto 10, agregarle .pf
    double? fontSize,

    /// Tamaño del icono por defecto 15
    double? tamanoIcono,

    /// Indica si es outline o no el boton.
    bool esOutline = false,
  }) {
    final colores = context.colores;

    return esOutline
        ? EscuelasBoton.outlined(
            onTap: onTap,
            context: context,
            estaHabilitado: true,
            texto: texto,
            color: color,
            borderRadius: BorderRadius.circular(4.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  texto,
                  style: TextStyle(
                    color: colorDeTexto ?? colores.background,
                    fontSize: fontSize ?? 12.pf,
                  ),
                ),
                SizedBox(width: 5.pw),
                Icon(
                  icono,
                  color: colorDeTexto ?? colores.background,
                  size: tamanoIcono ?? 15.sw,
                ),
              ],
            ),
          )
        : EscuelasBoton(
            estaHabilitado: true,
            onTap: onTap,
            color: color,
            borderRadius: BorderRadius.circular(4.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  texto,
                  style: TextStyle(
                    color: colorDeTexto ?? colores.background,
                    fontSize: fontSize ?? 12.pf,
                  ),
                ),
                SizedBox(width: 5.pw),
                Icon(
                  icono,
                  color: colores.background,
                  size: tamanoIcono ?? 15.sw,
                ),
              ],
            ),
          );
  }

  factory EscuelasBoton.loginGoogle({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,
    required String texto,
    double? width,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      estaHabilitado: false,
      onTap: onTap,
      width: width,
      height: 40.ph,
      color: colores.azul,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.gGoogle.path,
            width: 20.sw,
          ),
          SizedBox(width: 15.pw),
          Text(
            texto,
            style: TextStyle(
              fontSize: 15.pf,
              color: colores.background,
            ),
          ),
        ],
      ),
    );
  }

  /// Tiene borde customizable y permite recibir un icono.
  factory EscuelasBoton.outlinedConIcono({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,

    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Texto interno del boton
    required String texto,

    /// Icono del boton
    required Icon icono,

    /// Color del texto, por defecto blanco
    Color? colorDeTexto,

    /// Tamaño del texto por defecto 10, agregarle .pf
    double? fontSize,

    /// Ancho del boton
    double? width,

    /// Altura del boton
    double? height,

    /// Color del boton
    Color? color,

    /// Color outline del boton
    Color? colorOutline,

    /// Ancho del outline
    double? widthOutline,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      borderRadius: BorderRadius.all(
        Radius.circular(8.sw),
      ),
      colorOutline: colorOutline,
      widthOutline: widthOutline,
      estaHabilitado: estaHabilitado,
      esOutlined: true,
      onTap: onTap,
      width: width,
      height: height,
      color: color ?? colores.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            texto,
            style: TextStyle(
              color: colorDeTexto ?? colores.background,
              fontSize: fontSize ?? 14.pf,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 6.pw),
          icono,
        ],
      ),
    );
  }

  factory EscuelasBoton.outlined({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,

    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Texto interno del boton
    required String texto,

    /// Ancho del boton
    double? width,

    /// Altura del boton
    double? height,

    /// Color del boton
    Color? color,

    /// Contenido a mostrar dentro del boton.
    Widget? child,

    /// Borde redondeado
    BorderRadius? borderRadius,

    /// Color de los bordes.
    Color? colorOutline,

    /// Color de las letras del texto
    Color? colorTexto,

    /// Tamaño de la fuente del texto
    double? tamanioFuente,

    /// Ancho de la letras del texto
    FontWeight? anchoDeLasLetras,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      colorOutline: colorOutline,
      esOutlined: true,
      borderRadius: borderRadius,
      estaHabilitado: estaHabilitado,
      height: height,
      width: width,
      onTap: onTap,
      color: color ?? colores.background,
      child: child ??
          Center(
            child: Text(
              texto,
              style: TextStyle(
                color: estaHabilitado
                    ? colorTexto ?? colores.onSecondary
                    : colores.secondary,
                fontSize: tamanioFuente ?? 12.pf,
                fontWeight: anchoDeLasLetras,
              ),
            ),
          ),
    );
  }

  /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
  final bool estaHabilitado;

  /// Da diseño dependiendo si es outlined o fill.
  final bool esOutlined;

  /// Funcion al presionar el boton
  final VoidCallback? onTap;

  /// Ancho del boton, por defecto es 130. Parametro con .pw aplicado.
  final double? width;

  /// Altura del boton, por defecto es 40
  final double? height;

  /// Color del container cuando esta habilitado
  final Color color;

  /// Border radius, por defecto es circular(30.sw)
  final BorderRadiusGeometry? borderRadius;

  /// Widget que va a contener el boton, puede ser un texto o texto e iconos
  final Widget child;

  /// Color de background para cuando esta deshabilitado
  final Color? backgroundColorDeshabilitado;

  /// Color del outline
  final Color? colorOutline;

  /// Ancho del outline
  final double? widthOutline;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: estaHabilitado ? onTap : null,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(30.sw),
              color: esOutlined
                  ? colores.background
                  : estaHabilitado
                      ? color
                      : colores.secondary,
              border: esOutlined
                  ? Border.all(
                      color: estaHabilitado ? color : colores.secondary,
                      width: widthOutline ?? 1.pw,
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.ph,
                horizontal: 20.ph,
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
