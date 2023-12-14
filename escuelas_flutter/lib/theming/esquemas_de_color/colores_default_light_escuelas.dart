import 'package:flutter/material.dart';

/// Esquema de color claro por defecto de Escuelas
const themeDefaultEscuelas = ColorScheme.light(
  ///Color utilizado en los apartados de autenticacion para hinttext de los
  ///textfields, botones, textos, etc
  primary: Color(0xff170E68),

  /// Color utilizado en su mayoria para marcar un item seleccionado.
  primaryContainer: Color(0xff6788FF),

  /// Color a utilizarse en textos de items seleccionados
  onPrimary: Color(0xffEEEEEE),

  /// Color de fondo
  background: Color(0xffffffff),

  /// Color utilizado en titulos mayormente
  onBackground: Color(0xff1E1E1E),

  /// Color utilizado en items del bottom bar y de inhabilitado
  secondary: Color(0xffC0C0C0),

  /// Color utilizado en subtitulos
  onSecondary: Color(0xff979797),

  /// Color utilizado en las 'list tile'
  tertiary: Color(0xffF2F2F2),

  /// Color a utilizarse por ejemplo en el bottom nav bar.
  onTertiary: Color(0xffE1E1E1),

  /// Color utilizado en ocaciones de error y notificacion.
  error: Color(0xffFF4444),
);

/// ColorScheme base donde se agregan los colores adicionales al tema light.
extension EscuelasColorScheme on ColorScheme {
  /// Color verde utilizado para confirmar accion.
  Color get verdeConfirmar => const Color(0xff62B446);

  /// Color utilizado para el estado de cuarto de falta.
  Color get amarilloCuartoFalta => const Color(0xffE0CA01);

  /// Color utilizado para el estado de media falta.
  Color get naranjaMediaFalta => const Color(0xffFF7E21);

  /// Color utilizado para el estado de ausencia.
  //! TODO(Manu): solicitud de unificar con unificar con error
  Color get rojoAusencia => const Color(0xffE43939);

  /// Color utilizado para el contenedor de nota.
  //! TODO(Manu): solicitud de unificar con primaryContainer
  Color get azulNota => const Color(0xff2E75FF);

  /// Color utilizado en componentes inhabilitados.
  //! TODO(Manu): solicitud de unificar con secondary
  Color get grisInhabilitado => const Color(0xffB3B3B3);

  /// Color utilizado en list tile de materias, alumnos, etc.
  Color get violetaListTile => const Color(0xffB250FF);

  /// Color a utilizarse en botones de asistencia, datos personales, modificacion
  /// de cursos, etc.
  Color get coralBotones => const Color(0xffFF7B5E);

  /// Color utilizado en list tile de alumno, materia, background desktop.
//! TODO(Manu): solicitud de unificar con tertiary.
  Color get grisListTile => const Color(0xffe8e8e8);

  /// Color utilizado de fondo en los containers de version Desktop.
//! TODO(Manu): solicitud de unificar con onprimary y background.
  Color get marfilContainerDesktop => const Color(0xffF2F1FD);
}
