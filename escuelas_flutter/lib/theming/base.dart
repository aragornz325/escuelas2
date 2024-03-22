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

  /// Color utilizado en el botton navigation bar y en algunos botones.
  Color get violetaOscuroBottomNav => const Color(0xff65558F);

  /// Color a utilizarse en botones de asistencia, datos personales,modificacion
  /// de cursos, etc.
  Color get coralBotones => const Color(0xffFF7B5E);

  /// Color utilizado de fondo en version Desktop.
  Color get marfilBackgroundDesktop => const Color(0xffe8e8e8);

  /// Color utilizado de fondo de una notificacion.
  Color get azulNotificacion => const Color(0xff5274FF);

  /// Se utiliza para el color del texto Sin Calificacion(SC) o la flecha de
  /// containers expandibles
  Color get grisSC => const Color(0xff6D6D6D);

  /// Se utiliza para el color del box shadow del ElementoLista cuando
  /// esta presionado.
  Color get grisClaroSombreado => const Color(0xFFEEEEEE);

  /// Se utiliza para el fondo del campo de texto para ingresar una calificacion
  Color get azul => const Color(0xff2E75FF);

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

  /// Color utilizado en los tooltip background, dividers y en border
  /// de ElementoLista.
  Color get grisSobreBackground => const Color(0xffD9D9D9);

  /// Color gris utilizado en fechas y en otros iconos.
  Color get grisDetalleFecha => const Color(0xff8C8C8C);

  /// Color utilizado en los tooltip.
  Color get onBackgroundOpacidadCincuenta => onBackground.withOpacity(0.5);

  /// Este color es utilizable en los items del drawer cuando son seleccionados
  Color get primaryOpacidadVeinte => primary.withOpacity(0.2);

  /// Color utilizado para señalizar una calificacion mayor a 4 y menor a 7
  Color get amarilloCalificacionMediocre => const Color(0xffF9F36B);

  /// Color utilizado para señalizar una calificacion mayor a 7 y menor a 10
  Color get verdeCalificacionAprobada => const Color(0xff7FC068);

  /// Color utilizado en el promedio TEA
  Color get verdeTEA => const Color(0xff62B446);

  /// Color utilizado en el promedio TEP
  Color get naranjaTEP => const Color(0xffFF7E21);

  /// Color utilizado en el promedio TED
  Color get rojoTED => const Color(0xffFF4444);

  /// Indica que la fecha es reciente, se usa para indicar el vencimiento de
  /// la fecha de carga de calificaciones
  Color get fechaReciente => const Color(0xff2A820C);

  /// Indica que la fecha es moderadamente reciente, se usa para indicar el
  /// vencimiento de la fecha de carga de calificaciones
  Color get fechaModeradamenteReciente => const Color(0xff62B446);

  /// Indica que la fecha es tardia, se usa para indicar el vencimiento de
  /// la fecha de carga de calificaciones
  Color get fechaTardia => const Color(0xffFF7E21);

  /// Indica que la fecha es muy tardia, se usa para indicar el vencimiento de
  /// la fecha de carga de calificaciones
  Color get fechaMuyTardia => const Color(0xffE43939);

  /// Color utilizado para el fondo de los botones de registro cuando estan
  /// deshabilitados
  Color get botonRegistroDeshabilitado => const Color(0xff8B86B3);

  /// Devuelve un color que tan tarde se cargaron las calificaciones
  Color segunVencimientoFecha(int dia) {
    if (dia > 0 && dia <= 4) {
      return fechaReciente;
    } else if (dia > 4 && dia <= 6) {
      return fechaModeradamenteReciente;
    } else if (dia > 6 && dia <= 8) {
      return fechaTardia;
    } else if (dia > 8) {
      return fechaMuyTardia;
    } else {
      return onSecondary;
    }
  }

  /// Devuelve un color segun la proporcion de materias cargadas (la proporcion
  /// debe ser un valor entre 0 y 1)
  Color segunProporcionDeAsignaturasCargadas(double proporcion) {
    if (proporcion >= .9) {
      return verdeConfirmar;
    } else if (proporcion >= .7) {
      return naranjaMediaFalta;
    } else {
      return error;
    }
  }
}
