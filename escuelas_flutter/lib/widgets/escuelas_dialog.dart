import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template EscuelasDialog}
/// Componente de dialogo general para la app.
///
/// Dialog con tres factory:
/// - exitoso:
/// Se usa para el procedimiento de una operación y indicarle al usuario que
/// t0do salio correctamente.
///
/// - Fallido:
/// Se usa para el procedimiento de una operación y indicarle al usuario que
/// algo fallo.
///
/// - Confirmar:
/// Se usa para el procedimiento de una operación y indicarle al usuario que
/// requiera el permiso del usuario para ejecutar una función/procedimiento.
///
/// El Dialog general puede configurarse y no requiere ningún parámetro
/// obligatorio, lo que permite pasar varias propiedades para adaptarlo a sus
/// necesidades específicas.
/// {@endtemplate}
class EscuelasDialog extends StatelessWidget {
  /// {@macro EscuelasDialog}
  const EscuelasDialog({
    this.altura = 300,
    this.conBotonCancelar = false,
    this.conBotonOutline = false,
    this.conIconoCerrar = true,
    this.ancho,
    this.titulo,
    this.content,
    this.onTapConfirmar,
    this.iconoAlLadoDelTitulo,
    this.tituloBotonPrincipal,
    this.tituloDelBotonSecundario,
    this.colorDeFondoDelBotonSecundario,
    super.key,
  });

  /// `Dialog de éxito`:
  ///
  /// Se usa para el procedimiento de una operación y indicarle al usuario que
  /// t0do salio correctamente.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[onTap]`,`[titulo]` y
  /// `[context]`.
  factory EscuelasDialog.exitoso({
    required BuildContext context,
    required VoidCallback onTap,
    required String titulo,
    double altura = 100,
    double? ancho,
  }) {
    final colores = context.colores;

    return EscuelasDialog(
      ancho: ancho,
      altura: altura,
      onTapConfirmar: onTap,
      tituloBotonPrincipal: 'CONFIRMAR', //TODO(anyone) ver si se hace l10n
      content: Text(
        titulo,
        style: TextStyle(
          fontSize: 15.pf,
          fontWeight: FontWeight.w600,
          color: colores.grisSC,
        ),
      ),
    );
  }

  /// `Dialog fallido`:
  ///
  /// Se usa para el procedimiento de una operación y indicarle al usuario que
  /// algo fallo.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[onTap]`,`[titulo]` y
  /// `[context]`.
  factory EscuelasDialog.fallido({
    required BuildContext context,
    required VoidCallback onTap,
    required String titulo,
    double altura = 100,
    double? ancho,
    String? tituloDelBoton,
  }) {
    final colores = context.colores;

    return EscuelasDialog(
      ancho: ancho,
      altura: altura,
      tituloBotonPrincipal: tituloDelBoton,
      conBotonOutline: true,
      onTapConfirmar: onTap,
      content: Text(
        titulo,
        style: TextStyle(
          fontSize: 15.pf,
          fontWeight: FontWeight.w600,
          color: colores.grisSC,
        ),
      ),
    );
  }

  /// `Dialog fallido`:
  ///
  /// Se usa para el procedimiento de una operación y indicarle al usuario que
  /// algo fallo.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[onTapConfirmar]`,
  /// `[titulo]` y `[context]`.
  factory EscuelasDialog.confirmar({
    required BuildContext context,
    required VoidCallback onTapConfirmar,
    required String titulo,
    double altura = 100,
    double? ancho,
  }) {
    final colores = context.colores;

    return EscuelasDialog(
      ancho: ancho,
      altura: altura,
      conBotonCancelar: true,
      onTapConfirmar: onTapConfirmar,
      tituloDelBotonSecundario: 'RECHAZAR', //TODO(anyone) ver si se hace l10n
      colorDeFondoDelBotonSecundario: colores.error,
      content: Text(
        titulo,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.pf,
          fontWeight: FontWeight.w600,
          color: colores.grisSC,
        ),
      ),
    );
  }

  /// Altura del dialogo por defecto en `300` (sin .ph) de [EscuelasDialog].
  final double altura;

  /// Indica si quiere mostrar el Icono de cerrar en el dialogo
  /// `(por defecto esta el .pop)`de [EscuelasDialog].
  final bool conIconoCerrar;

  /// Indica si quiere mostrar con botón outline en el dialogo
  /// `(por defecto esta el .pop)` de [EscuelasDialog].
  final bool conBotonOutline;

  /// Indica si quiere mostrar con botón de cancelar en el Dialog
  /// `(por defecto esta el .pop)`de [EscuelasDialog].
  final bool conBotonCancelar;

  /// Callback para el botón de confirmar,este se ejecuta al presionar
  /// el botón de [EscuelasDialog].
  final VoidCallback? onTapConfirmar;

  /// Ancho del dialogo (sin .pw) de [EscuelasDialog].
  final double? ancho;

  /// Titulo del dialogo de [EscuelasDialog].
  final String? titulo;

  /// Cuerpo/contenido del dialogo de [EscuelasDialog].
  final Widget? content;

  /// Titulo del botón de `Confirmar` de [EscuelasDialog].
  final String? tituloBotonPrincipal;

  /// Icono al lado del titulo de [EscuelasDialog].
  final IconData? iconoAlLadoDelTitulo;

  /// Titulo del botón de `Cancelar` o `Rechazar` de [EscuelasDialog].
  final String? tituloDelBotonSecundario;

  /// Color de fondo del botón de `Cancelar` o `Rechazar` de [EscuelasDialog].
  final Color? colorDeFondoDelBotonSecundario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final titulo = this.titulo;

    return AlertDialog(
      content: SizedBox(
        height: altura,
        width: ancho,
        child: Column(
          children: [
            Row(
              children: [
                if (iconoAlLadoDelTitulo != null)
                  Icon(
                    iconoAlLadoDelTitulo,
                    size: 20.pw,
                    color: colores.onBackground,
                  ),
                if (iconoAlLadoDelTitulo != null) SizedBox(width: 5.pw),
                if (titulo != null)
                  SizedBox(
                    width: 150.pw,
                    child: Text(
                      titulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.pf,
                        fontWeight: FontWeight.w600,
                        color: colores.onBackground,
                      ),
                    ),
                  ),
                if (conIconoCerrar) const Spacer(),
                if (conIconoCerrar)
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 18.pw,
                      color: colores.onBackground,
                    ),
                  ),
              ],
            ),
            content ?? const SizedBox.shrink(),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        if (conBotonCancelar)
          EscuelasBoton.texto(
            onTap: () => Navigator.of(context).pop(),
            estaHabilitado: true,
            context: context,
            texto: tituloDelBotonSecundario ??
                'cancelar', //TODO(anyone) ver si se hace l10n
            color: colorDeFondoDelBotonSecundario ?? colores.onSecondary,
          ),
        if (conBotonOutline)
          EscuelasBoton.outlined(
            context: context,
            width: 130.pw,
            height: max(30.sh, 30.ph),
            onTap: () => onTapConfirmar,
            estaHabilitado: true,
            color: colores.grisSC,
            texto: tituloBotonPrincipal ??
                'VOLVER', //TODO(anyone) ver si se hace l10n
          )
        else
          EscuelasBoton.texto(
            context: context,
            onTap: () => onTapConfirmar,
            estaHabilitado: true,
            color: colores.verdeConfirmar,
            texto: tituloBotonPrincipal ??
                'CONFIRMAR', //TODO(anyone) ver si se hace l10n
          ),
      ],
    );
  }
}
