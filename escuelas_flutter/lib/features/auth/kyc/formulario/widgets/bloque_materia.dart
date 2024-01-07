import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/formulario_dropdown.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

    final l10n = context.l10n;

    return BlocBuilder<BlocKyc, BlocKycEstado>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.pw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // TODO(Gon): Cambiar esta logica cuando esten los permisos/roles bien definidos
                state.rolElegido!.nombre == 'Mati'
                    ? l10n.pageKycFormWhatGradeAreYouIn
                    : l10n.pageKycFormWhatYearIsYourSubject,
                style: TextStyle(
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.pf,
                ),
              ),
              SizedBox(height: 5.ph),
              FormularioDropdown(
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
              // TODO(Gon): Cambiar esta logica cuando esten los permisos/roles bien definidos
              if (state.rolElegido!.nombre == 'Chepibe')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.pageKycFormWhichSubjectIsIt,
                      style: TextStyle(
                        color: colores.onBackground,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.pf,
                      ),
                    ),
                    SizedBox(height: 5.ph),
                    FormularioDropdown(
                      lista: state.listaOpcionesAsignaturas,
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
            ],
          ),
        );
      },
    );
  }
}
