import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/widgets/kyc_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BloqueMateria}
/// Pregunta de que año es la materia y un dropdown para seleccionar el año
/// Tambien pregunta la materia y un dropdown para seleccionarla
/// {@endtemplate}
class BloqueMateria extends StatelessWidget {
  /// {@macro BloqueMateria}
  const BloqueMateria({
    required this.id,
    super.key,
  });

  /// Id del bloque
  final int id;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocKyc, BlocKycEstado>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.pw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // TODO(Gon): l10n
                '¿De qué año es tu materia?',
                style: TextStyle(
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.pf,
                ),
              ),
              SizedBox(height: 5.ph),
              KycDropdown(
                lista: state.listaOpcionesCursos,
                listaOpcionesSeleccionadas: (value) =>
                    context.read<BlocKyc>().add(
                          BlocKycEventoSeleccionarCursoYMateria(
                            idOpcion: id,
                            idCurso: value[0].id,
                          ),
                        ),
              ),
              SizedBox(height: 20.ph),
              Text(
                // TODO(Gon): l10n
                '¿Qué materia es?',
                style: TextStyle(
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.pf,
                ),
              ),
              SizedBox(height: 5.ph),
              KycDropdown(
                lista: state.listaOpcionesMaterias,
                listaOpcionesSeleccionadas: (value) =>
                    context.read<BlocKyc>().add(
                          BlocKycEventoSeleccionarCursoYMateria(
                            idOpcion: id,
                            idMateria: value[0].id,
                          ),
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}
