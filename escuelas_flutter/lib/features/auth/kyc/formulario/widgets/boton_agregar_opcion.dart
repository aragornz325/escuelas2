import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonAgregarOpcion}
/// Botón para agregar una opcion al formulario
/// {@endtemplate}
class BotonAgregarOpcion extends StatelessWidget {
  /// {@macro BotonAgregarOpcion}
  BotonAgregarOpcion({
    super.key,
  });
  late int asignaturaSeleccionada;
  late int cursoSeleccionado;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return TextButton.icon(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (_) => BlocProvider(
          create: (context) => BlocKyc(),
          child: EscuelasDialog.confirmar(
            context: context,
            onTapConfirmar: () {
              context.read<BlocKyc>().add(
                    BlocKycEventoAgregarOpcion(
                      idAsignaturaSeleccionada: asignaturaSeleccionada,
                      idCursoSeleccionado: cursoSeleccionado,
                    ),
                  );
            },
            content: BlocBuilder<BlocKyc, BlocKycEstado>(
              builder: (context, state) {
                return Column(
                  children: [
                    FormularioDropdown(
                      lista: state.listaAsignaturas
                          .map(
                            (e) => PRDropdownOption(
                              value: e.id ?? 0,
                              title: e.nombre,
                            ),
                          )
                          .toList(),
                      listaOpcionesSeleccionadas: (value) {
                        final valor = value.first;
                        asignaturaSeleccionada = valor.value;
                      },
                    ),
                    FormularioDropdown(
                      lista: state.listaCursos
                          .map(
                            (e) => PRDropdownOption(
                              value: e.id ?? 0,
                              title: e.nombre,
                            ),
                          )
                          .toList(),
                      listaOpcionesSeleccionadas: (value) {
                        final valor = value.first;
                        cursoSeleccionado = valor.value;
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      icon: Icon(
        Icons.add_circle_outline_outlined,
        color: colores.onBackground,
        size: 18.pw,
      ),
      label: Text(
        l10n.pageKycFormAddSubject.toUpperCase(),
        style: TextStyle(
          color: colores.onBackground,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w700,
          fontSize: 15.pf,
        ),
      ),
    );
  }
}
