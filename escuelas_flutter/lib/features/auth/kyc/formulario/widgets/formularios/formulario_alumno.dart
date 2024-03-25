import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/formularios/dialogs/dialog_seleccionar_comision.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FormularioAlumno}
/// Formulario para el rol 'estudiante'
/// {@endtemplate}
class FormularioAlumno extends StatelessWidget {
  /// {@macro FormularioAlumno}
  const FormularioAlumno({super.key});

  /// Muestra el popup para seleccionar una comision
  Future<void> _onSeleccionadorComision(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocKyc>(),
          child: const SeleccionarComision(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocKyc, BlocKycEstado>(
      listener: (context, state) {
        if (state is BlocKycEstadoErrorOpcionYaElegida) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: colores.grisDato,
              content: Text(l10n.pageKycErrorOptionAlreadySelected),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BlocKycEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.pw)
                      .copyWith(top: 20.ph, bottom: 40.ph),
                  child: Text(
                    l10n.pageKycFormDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.pf,
                    ),
                  ),
                ),
                if (state.opcionesFormulario.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.pw),
                    child: Column(
                      children: state.opcionesFormulario
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(bottom: 10.ph),
                              child: ElementoLista.kyc(
                                onTapWidgetLateralDerecho: () =>
                                    context.read<BlocKyc>().add(
                                          BlocKycEventoEliminarOpcion(
                                            idOpcion: e.idOpcion,
                                          ),
                                        ),
                                nombreAsignatura:
                                    e.asignaturaSeleccionada?.nombre ?? '',
                                nombreComision:
                                    e.comisionSeleccionada?.nombre ?? '',
                                context: context,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            ),
            if (state.opcionesFormulario.isEmpty)
              Center(
                child: Text(
                  l10n.pageKycFormNoSelectedComission,
                  style: TextStyle(
                    color: colores.onSecondary,
                    fontSize: 18.pf,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.ph),
              child: Column(
                children: [
                  BotonAgregarOpcion(
                    deshabilitado: state.opcionesFormulario.isNotEmpty,
                    textoBoton: l10n.pageKycFormChooseComission,
                    onPressed: () => _onSeleccionadorComision(context),
                  ),
                  if (state.opcionesFormulario.isNotEmpty)
                    Text(
                      l10n.pageKycFormErrorMaxCommissionsReached,
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  SizedBox(height: 20.ph),
                  const BotonSolicitarRol(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
