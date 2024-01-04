import 'package:flutter/material.dart';

/// ColorScheme base donde se agregan los colores adicionales al tema light.
extension EscuelasColorScheme on ColorScheme {
  /// Color verde utilizado para confirmar accion.
  Color get verdeConfirmar => const Color(0xff62B446);

  /// Color utilizado para el estado de cuarto de falta.
  Color get amarilloCuartoFalta => const Color(0xffE0CA01);

  /// Color utilizado para el estado de media falta.
  Color get naranjaMediaFalta => const Color(0xffFF7E21);

  /// Color utilizado en list tile de materias, alumnos, etc.
  Color get violetaListTile => const Color(0xffB250FF);

  /// Color a utilizarse en botones de asistencia, datos personales,modificacion
  /// de cursos, etc.
  Color get coralBotones => const Color(0xffFF7B5E);

  /// Color utilizado de fondo en version Desktop.
  Color get marfilBackgroundDesktop => const Color(0xffe8e8e8);

  /// Se utiliza para el color del texto Sin Calificacion(SC) o la flecha de
  /// containers expandibles
  Color get grisSC => const Color(0xff6D6D6D);

  /// Se utiliza para el color del box shadow del ElementoLista cuando
  /// esta presionado.
  Color get grisClaroSombreado => const Color(0xFFEEEEEE);

  /// Se utiliza para el fondo del campo de texto para ingresar una calificacion
  Color get azul => const Color(0xff2E75FF);

  /// Color utilizado en el promedio TEA
  Color get verdeTEA => const Color(0xff62B446);

  /// Color utilizado en el promedio TEP
  Color get naranjaTEP => const Color(0xffFF7E21);

  /// Color utilizado en el promedio TED
  Color get rojoTED => const Color(0xffFF4444);

  /// Color utilizado para los componentes deshabilitados
  Color get grisDeshabilitado => const Color(0xffCCCCCC);

  /// Color utilizado para los componentes deshabilitados
  Color get grisBotonPresionado => const Color(0xffE2E2E2);

  /// Color utilizado en los datos personales de los usuarios
  Color get grisDato => const Color(0xff878787);

  /// Color utilizado en el drawer para hacer transparente
  /// y que se vea el background.
  Color get transparente => const Color.fromRGBO(0, 0, 0, 0);

  /// Color utilizado en el drawer para hacer sombreado al background.
  Color get onSecondaryOpacidadTreinta => onSecondary.withOpacity(0.3);
}
