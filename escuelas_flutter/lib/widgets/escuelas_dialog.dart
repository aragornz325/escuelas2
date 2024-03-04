import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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
    required this.onTapConfirmar,
    this.altura,
    this.conBotonCancelar = false,
    this.conBotonOutline = false,
    this.conIconoCerrar = true,
    this.estaHabilitado = true,
    this.shape,
    this.ancho,
    this.titulo,
    this.content,
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
    required Widget content,
    ShapeBorder? shape,
    String? titulo,
    double altura = 100,
    double? ancho,
  }) {
    final l10n = context.l10n;

    return EscuelasDialog(
      shape: shape,
      ancho: ancho,
      altura: altura,
      onTapConfirmar: onTap,
      tituloBotonPrincipal: l10n.commonConfirm.toUpperCase(),
      titulo: titulo,
      content: content,
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
    required VoidCallback onTap,
    required Widget content,
    String? titulo,
    double altura = 100,
    double? ancho,
    String? tituloDelBoton,
  }) {
    return EscuelasDialog(
      ancho: ancho,
      altura: altura,
      tituloBotonPrincipal: tituloDelBoton,
      conBotonOutline: true,
      onTapConfirmar: onTap,
      titulo: titulo,
      content: content,
    );
  }

  /// `Dialog característica no disponible`:
  ///
  /// Se usa para mostrar un mensaje de error en caso de que la característica
  /// solicitada no esté desarrollada o disponible.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[context]`.
  factory EscuelasDialog.featNoDisponible({
    required BuildContext context,
  }) {
    final l10n = context.l10n;

    final colores = context.colores;

    return EscuelasDialog(
      onTapConfirmar: () => Navigator.of(context).pop(),
      titulo: l10n.commonDialogError,
      content: Padding(
        padding: EdgeInsets.only(
          right: 10.pw,
          left: 10.pw,
          top: max(10.ph, 10.sh),
        ),
        child: Center(
          child: Text(
            l10n.commonFeatureNotAvailable,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.pf,
              color: colores.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// `Dialog confirmar`:
  ///
  /// Se usa para el procedimiento de una operación y pedirle al usuario una
  /// confirmacion.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[onTapConfirmar]`,
  /// `[titulo]` y `[context]`.
  factory EscuelasDialog.confirmar({
    required VoidCallback onTapConfirmar,
    required Widget content,
    String? titulo,
    double? altura,
    double? ancho,
  }) {
    return EscuelasDialog(
      ancho: ancho,
      altura: altura,
      onTapConfirmar: onTapConfirmar,
      content: content,
      titulo: titulo,
    );
  }

  /// `Dialog confirmar`:
  ///
  /// Se usa para el procedimiento de una operación y pedirle al usuario una
  /// confirmacion.
  ///
  /// El Dialog requiere obligatoriamente la propiedad `[onTapConfirmar]`,
  /// `[titulo]` y `[context]`.
  factory EscuelasDialog.solicitudDeAccion({
    required BuildContext context,
    required VoidCallback onTapConfirmar,
    required Widget content,
    ShapeBorder? shape,
    String? titulo,
    double? altura,
    double? ancho,
  }) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog(
      shape: shape,
      ancho: ancho,
      altura: altura,
      onTapConfirmar: onTapConfirmar,
      conIconoCerrar: false,
      conBotonCancelar: true,
      tituloDelBotonSecundario: l10n.commonCancel.toUpperCase(),
      colorDeFondoDelBotonSecundario: colores.error,
      content: content,
      titulo: titulo,
    );
  }

  /// AlertDialog para consultar si desea cerrar sesión
  factory EscuelasDialog.logOut({
    required BuildContext context,
    required VoidCallback onCerrarSesion,
  }) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog(
      onTapConfirmar: onCerrarSesion,
      iconoAlLadoDelTitulo: Icons.logout_outlined,
      titulo: l10n.drawerLogOut,
      content: Padding(
        padding: EdgeInsets.only(top: 10.ph),
        child: Center(
          child: Text(
            l10n.dialogLogoutQuestion,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16.pf,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      conBotonCancelar: true,
      colorDeFondoDelBotonSecundario: colores.azul,
    );
  }

  /// Altura del dialogo por defecto en `300` (sin .ph) de [EscuelasDialog].
  final double? altura;

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
  final void Function() onTapConfirmar;

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

  /// Indica si el dialogo se encuentra habilitado o no.
  final bool estaHabilitado;

  /// Shape/Borderes del dialogo de [EscuelasDialog].
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final titulo = this.titulo;

    final l10n = context.l10n;

    return AlertDialog(
      shape: shape,
      content: SizedBox(
        height: altura,
        width: ancho,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconoAlLadoDelTitulo != null)
                  Icon(
                    iconoAlLadoDelTitulo,
                    size: 20.pw,
                    color: colores.onBackground,
                  ),
                if (iconoAlLadoDelTitulo != null) SizedBox(width: 5.pw),
                if (titulo != null)
                  Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.pf,
                      fontWeight: FontWeight.w600,
                      color: colores.onBackground,
                    ),
                  ),
                if (conIconoCerrar) const Spacer(),
                if (conIconoCerrar)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      size: 18.pw,
                      color: colores.secondary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.ph),
            content ?? const SizedBox.shrink(),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (conBotonCancelar)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.pw),
                child: EscuelasBoton.texto(
                  onTap: () => Navigator.of(context).pop(),
                  estaHabilitado: true,
                  context: context,
                  texto: tituloDelBotonSecundario ??
                      l10n.commonCancel.toUpperCase(),
                  color: colorDeFondoDelBotonSecundario ?? colores.onSecondary,
                ),
              ),
            if (conBotonOutline)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.pw),
                child: EscuelasBoton.outlined(
                  context: context,
                  onTap: estaHabilitado ? onTapConfirmar : () {},
                  estaHabilitado: estaHabilitado,
                  // TODO(anyone): Hacer permita pasarle color del boton
                  color: colores.verdeConfirmar,
                  texto: tituloBotonPrincipal ?? l10n.commonBack,
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.pw),
                child: EscuelasBoton.texto(
                  context: context,
                  onTap: estaHabilitado ? onTapConfirmar : () {},
                  estaHabilitado: estaHabilitado,
                  color: estaHabilitado
                      ? colores.verdeConfirmar
                      : colores.grisDeshabilitado,
                  texto:
                      tituloBotonPrincipal ?? l10n.commonConfirm.toUpperCase(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
