import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/widgets/kyc_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class PreguntaYRespuesta extends StatelessWidget {
  const PreguntaYRespuesta({
    required this.id,
    super.key,
  });
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
                value: (value) => context.read<BlocKyc>().add(
                      BlocKycEventoSeleccionarCursoYMateria(
                        idOpcion: id,
                        idCurso: value[0].id,
                      ),
                    ),
              ),
              SizedBox(height: 20.ph),
              Text(
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
                value: (value) => context.read<BlocKyc>().add(
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
