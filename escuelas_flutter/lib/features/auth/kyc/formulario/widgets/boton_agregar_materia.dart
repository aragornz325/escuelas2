import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonAgregarBloqueMateria}
/// Botón para agregar un [BloqueMateria]
/// {@endtemplate}
class BotonAgregarBloqueMateria extends StatelessWidget {
  /// {@macro BotonAgregarBloqueMateria}
  const BotonAgregarBloqueMateria({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return TextButton.icon(
      onPressed: () =>
          context.read<BlocKyc>().add(const BlocKycEventoAgregarOpcion()),
      icon: const Icon(
        Icons.add_circle_outline_outlined,
      ),
      label: Text(
        l10n.pageKycFormAddSubject.toUpperCase(),
        style: TextStyle(
          color: colores.onBackground,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w700,
          fontSize: 12.pf,
        ),
      ),
    );
  }
}
