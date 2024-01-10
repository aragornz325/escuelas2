import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';

/// Extensiones para el estado de asistencia.
/// Funciones:
///
/// Retornar un `Color` dependiendo del estado de la asistencia.
///
/// Retornar un `String` dependiendo del estado de la asistencia.
///
/// Retornar la `Cantidad de alumnos` que no asistieron.
///
/// Función para `Cambiar el estado` dependiendo del estado anterior.
extension EstadoDeAsistenciaX on EstadoDeAsistencia {
  /// Devuelve el color dependiendo del estado de la asistencia.
  Color colorEstado(BuildContext context) {
    final colores = context.colores;

    return switch (this) {
      EstadoDeAsistencia.presente => colores.verdeConfirmar,
      EstadoDeAsistencia.mediaInasistencia => colores.amarilloCuartoFalta,
      EstadoDeAsistencia.cuartoDeInasistencia => colores.naranjaTEP,
      EstadoDeAsistencia.ausente => colores.rojoTED,
      _ => colores.grisSC,
    };
  }

  /// Devuelve el nombre dependiendo del estado de la asistencia.
  String nombreEstado(BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      EstadoDeAsistencia.presente => l10n.commonPresent,
      EstadoDeAsistencia.ausente => l10n.commonAbsent,
      EstadoDeAsistencia.mediaInasistencia => l10n.commonHalfAbsence,
      EstadoDeAsistencia.cuartoDeInasistencia => l10n.commonFourthMissing,
      _ => l10n.commonUndefined,
    };
  }

  /// Cambia el estado Dependiendo de la anterior Asistencia/Inasistencia.
  EstadoDeAsistencia cambiarEstado() {
    return switch (this) {
      EstadoDeAsistencia.presente => EstadoDeAsistencia.mediaInasistencia,
      EstadoDeAsistencia.mediaInasistencia =>
        EstadoDeAsistencia.cuartoDeInasistencia,
      EstadoDeAsistencia.cuartoDeInasistencia => EstadoDeAsistencia.ausente,
      EstadoDeAsistencia.ausente => EstadoDeAsistencia.presente,
      _ => EstadoDeAsistencia.presente,
    };
  }

  /// Cantidad de alumnos que no asistieron
  int cantidadDeAlumnos(
    List<RelacionComisionUsuario> usuarios,
    List<AsistenciaDiaria> asistenciasDiarias,
    EstadoDeAsistencia estado,
  ) {
    return usuarios.where((usuario) {
      return asistenciasDiarias.any(
        (asistencia) =>
            asistencia.estudianteId == usuario.usuarioId &&
            asistencia.estadoDeAsistencia != EstadoDeAsistencia.presente &&
            asistencia.estadoDeAsistencia != EstadoDeAsistencia.sinEstado &&
            asistencia.estadoDeAsistencia == estado,
      );
    }).length;
  }

  /// Verifica si existe una inasistencia de la lista
  bool existeInasistencia({
    required List<AsistenciaDiaria> asistenciasDiarias,
    required int idEstudiante,
    required DateTime fecha,
  }) {
    return asistenciasDiarias.any(
      (asistencia) =>
          (asistencia.ultimaModificacion?.mismaFecha(fecha) ?? false) &&
          asistencia.estudianteId == idEstudiante,
    );
  }

  /// Verificar si ya existe una inasistencia exactamente igual
  bool tieneLaMismaInasistencia({
    required List<AsistenciaDiaria> asistenciasDiarias,
    required int idEstudiante,
    required DateTime fecha,
    required EstadoDeAsistencia estado,
  }) {
    return asistenciasDiarias.any(
      (asistencia) =>
          (asistencia.ultimaModificacion?.mismaFecha(fecha) ?? false) &&
          asistencia.estudianteId == idEstudiante &&
          asistencia.estadoDeAsistencia == estado,
    );
  }

  /// Verifica si existe un estudiante con el id
  bool existeMismoEstudiante(
    List<AsistenciaDiaria> asistenciasDiarias,
    int idEstudiante,
  ) {
    return asistenciasDiarias.any(
      (asistencia) => asistencia.estudianteId == idEstudiante,
    );
  }
}
