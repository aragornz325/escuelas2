import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularFormulario}
/// Vista celular de la pantalla 'Formulario'
/// {@endtemplate}
class VistaCelularFormulario extends StatelessWidget {
  /// {@macro VistaCelularFormulario}
  const VistaCelularFormulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocKyc, BlocKycEstado>(
      listener: (context, state) {
        if (state is BlocKycEstadoExitoAlSolicitarRegistro) {
          Navigator.of(context).pop();
          context.router.replace(const RutaEspera());
        }
      },
      builder: (context, state) {
        if (state is BlocKycEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 40.ph),
          child: Column(
            children: [
              SizedBox(height: 20.ph),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.pw),
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
              if (state.opcionesFormulario.isEmpty)
                const Text(
                  'Agrega las asignaturas quetengas asignadas para continuar',
                ),
              ...state.opcionesFormulario.map(
                (e) => ElementoLista(
                  texto: Text('${e.nombreAsignaturaSeleccionado}'
                      '${e.nombreCursoSeleccionado}'),
                  widgetLateralDerecho: GestureDetector(
                    onTap: () => context
                        .read<BlocKyc>()
                        .add(BlocKycEventoEliminarOpcion(idOpcion: e.idOpcion)),
                    child: const Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.ph),
              BotonAgregarOpcion(),
              SizedBox(height: 20.ph),
              const BotonSolicitarRol(),
            ],
          ),
        );
      },
    );
  }
}
