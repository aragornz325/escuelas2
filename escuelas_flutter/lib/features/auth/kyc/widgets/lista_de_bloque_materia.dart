import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeBloqueMateria}
/// Lista de bloques de materias donde se puede elegir año y materia
/// {@endtemplate}
class ListaDeBloqueMateria extends StatelessWidget {
  /// {@macro ListaDeBloqueMateria}
  const ListaDeBloqueMateria({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<BlocKyc, BlocKycEstado>(
          builder: (context, state) {
            return Column(
              children: [
                ...state.opcionesKyc.map(
                  (e) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.ph),
                        child: BloqueMateria(id: e.id),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
