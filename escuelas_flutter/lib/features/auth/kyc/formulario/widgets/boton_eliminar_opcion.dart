import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonEliminarOpcion}
/// Botón para agregar un [BloqueMateria]
/// {@endtemplate}
class BotonEliminarOpcion extends StatelessWidget {
  /// {@macro BotonEliminarOpcion}
  const BotonEliminarOpcion({
    required this.idBloque,
    super.key,
  });
  final int idBloque;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return TextButton.icon(
      onPressed: () => context
          .read<BlocKyc>()
          .add(BlocKycEventoEliminarOpcion(idOpcion: idBloque)),
      icon: Icon(
        Icons.add_circle_outline_outlined,
        color: colores.error,
        size: 18.pw,
      ),
      label: Text(
        l10n.pageKycFormDeleteSubject.toUpperCase(),
        style: TextStyle(
          color: colores.error,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w700,
          fontSize: 15.pf,
        ),
      ),
    );
  }
}
