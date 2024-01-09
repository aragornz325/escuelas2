import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SeleccionarAsignaturaPorComision}
/// Dialogo para seleccionar una asignatura por comision
/// {@endtemplate}
class SeleccionarAsignaturaPorComision extends StatefulWidget {
  /// {@macro SeleccionarAsignaturaPorComision}
  const SeleccionarAsignaturaPorComision({super.key});

  @override
  State<SeleccionarAsignaturaPorComision> createState() =>
      _SeleccionarAsignaturaPorComisionState();
}

class _SeleccionarAsignaturaPorComisionState
    extends State<SeleccionarAsignaturaPorComision> {
  /// Id de la asignatura seleccionada
  int? idAsignaturaSeleccionada;

  /// Id de la comision seleccionada
  int? idComisionSeleccionada;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog(
      estaHabilitado:
          idAsignaturaSeleccionada != null && idComisionSeleccionada != null,
      onTapConfirmar: () {
        context.read<BlocKyc>().add(
              BlocKycEventoAgregarOpcionDocente(
                idAsignaturaSeleccionada: idAsignaturaSeleccionada!,
                idComisionSeleccionada: idComisionSeleccionada!,
              ),
            );
        Navigator.of(context).pop();
      },
      conIconoCerrar: false,
      conBotonCancelar: true,
      tituloDelBotonSecundario: l10n.commonCancel.toUpperCase(),
      colorDeFondoDelBotonSecundario: colores.error,
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
                      (e) => EscuelasDropdownOption(
                        value: e.id ?? 0,
                        title: e.nombre,
                      ),
                    )
                    .toList(),
                listaOpcionesSeleccionadas: (opcion) =>
                    setState(() => idAsignaturaSeleccionada = opcion.value),
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
                      (e) => EscuelasDropdownOption(
                        value: e.id ?? 0,
                        title: e.nombre,
                      ),
                    )
                    .toList(),
                listaOpcionesSeleccionadas: (opcion) =>
                    setState(() => idComisionSeleccionada = opcion.value),
              ),
            ],
          );
        },
      ),
      titulo: l10n.pageKycFormChooseSubject,
    );
  }
}
