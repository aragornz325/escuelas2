import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/formularios/formulario_alumno.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/formularios/formulario_docente.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaCelularFormulario}
/// Vista celular de la pantalla 'Formulario'
/// {@endtemplate}
class VistaCelularFormulario extends StatelessWidget {
  /// {@macro VistaCelularFormulario}
  const VistaCelularFormulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = context.read<BlocKyc>().state;

    final rol = state.rolElegido?.name;

    return switch (rol) {
      'Alumno' => const FormularioAlumno(),
      'Docente' => const FormularioDocente(),
      _ => Center(
          child: Text(l10n.commonFeatureNotAvailable),
        )
    };
  }
}
