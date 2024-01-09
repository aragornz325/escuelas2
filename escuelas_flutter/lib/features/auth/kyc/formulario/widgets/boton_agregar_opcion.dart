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
  const BotonAgregarOpcion({
    required this.content,
    required this.onTapConfirmar,
    required this.context,
    required this.titulo,
    required this.textoBoton,
    super.key,
  });
  factory BotonAgregarOpcion.docente({required BuildContext context}) {
    late int asignaturaSeleccionada;

    late int cursoSeleccionado;

    final colores = context.colores;

    final l10n = context.l10n;

    return BotonAgregarOpcion(
      textoBoton: l10n.pageKycFormAddSubject,
      titulo: 'Elegi tu asignatura',
      context: context,
      onTapConfirmar: () {
        context.read<BlocKyc>().add(
              BlocKycEventoAgregarOpcionDocente(
                idAsignaturaSeleccionada: asignaturaSeleccionada,
                idComisionSeleccionada: cursoSeleccionado,
              ),
            );
      },
      content: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.ph),
                child: Text(
                  l10n.pageKycFormWhatYearIsYourSubject,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.pf,
                  ),
                ),
              ),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.ph),
                child: Text(
                  l10n.pageKycFormWhichSubjectIsIt,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.pf,
                  ),
                ),
              ),
              FormularioDropdown(
                lista: state.listaComisiones
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
    );
  }
  factory BotonAgregarOpcion.alumno({required BuildContext context}) {
    late int comisionSeleccionada;
    final colores = context.colores;
    final l10n = context.l10n;
    return BotonAgregarOpcion(
      textoBoton: l10n.pageKycFormAddSubject,
      titulo: 'Elegi tu comision',
      context: context,
      onTapConfirmar: () => context.read<BlocKyc>().add(
            BlocKycEventoAgregarOpcionAlumno(
              idComisionSeleccionada: comisionSeleccionada,
            ),
          ),
      content: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.ph),
                child: Text(
                  l10n.pageKycFormWhatGradeAreYouIn,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.pf,
                  ),
                ),
              ),
              FormularioDropdown(
                lista: state.listaComisiones
                    .map(
                      (e) => PRDropdownOption(
                        value: e.id ?? 0,
                        title: e.nombre,
                      ),
                    )
                    .toList(),
                listaOpcionesSeleccionadas: (value) {
                  final valor = value.first;
                  comisionSeleccionada = valor.value;
                },
              ),
            ],
          );
        },
      ),
    );
  }
  final BuildContext context;
  final Widget content;
  final void Function() onTapConfirmar;
  final String titulo;
  final String textoBoton;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return TextButton.icon(
      onPressed: () => showDialog<void>(
        context: context,
        builder: (_) => BlocProvider(
          create: (context) => BlocKyc(),
          child: EscuelasDialog.solicitudDeAccion(
            context: context,
            titulo: titulo,
            onTapConfirmar: onTapConfirmar,
            content: content,
          ),
        ),
      ),
      icon: Icon(
        Icons.add_circle_outline_outlined,
        color: colores.onBackground,
        size: 18.pw,
      ),
      label: Text(
        textoBoton.toUpperCase(),
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
