import 'package:flutter/material.dart';

//! TODO(Manu): Cuando vir unifique colores, revisar cuales quedaron.

/// Esquema de color claro por defecto de Escuelas
const themeDefaultEscuelas = ColorScheme.light(
  /// Color utilizado en los apartados de autenticacion para hinttext de los
  /// textfields, botones, textos, etc
  primary: Color(0xff170E68),

  /// Color utilizado en su mayoria para marcar un item seleccionado.
  primaryContainer: Color(0xff6788FF),

  /// Color a utilizarse en textos de items seleccionados
  onPrimary: Color(0xffffffff),

  /// Color de fondo Mobile
  background: Color(0xffEEEEEE),

  /// Color utilizado en titulos mayormente
  onBackground: Color(0xff1E1E1E),

  /// Color utilizado en items del bottom bar y de inhabilitado
  secondary: Color(0xffC0C0C0),

  /// Color utilizado en subtitulos
  onSecondary: Color(0xff979797),

  /// Color utilizado en las 'list tile', background desktop.
  tertiary: Color(0xffF2F2F2),

  /// Color a utilizarse por ejemplo en el bottom nav bar.
  onTertiary: Color(0xffE1E1E1),

  /// Color utilizado en ocaciones de error notificacion y ausencia.
  error: Color(0xffFF4444),
);
