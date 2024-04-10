import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/auth/registro/bloc/bloc_registro.dart';
import 'package:escuelas_flutter/features/auth/registro/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularRegistro}
/// Vista de registro para dispositivos móviles.
/// {@endtemplate}
class VistaCelularRegistro extends StatelessWidget {
  /// {@macro VistaCelularRegistro}
  const VistaCelularRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<BlocRegistro, BlocRegistroEstado>(
      listener: (context, state) {
        if (state is BlocRegistroEstadoFaltaCompletarKyc ||
            state is BlocRegistroEstadoSolicitudRechazada ||
            state is BlocRegistroEstadoExitosoAlRegistrar) {
          context.replaceRoute(const RutaKyc());
        }

        if (state is BlocRegistroEstadoSolicitudPendiente) {
          context.replaceRoute(const RutaEspera());
        }

        if (state is BlocRegistroEstadoSolicitudAceptada) {
          context.replaceRoute(
            RutaDashboard(
              usuario: state.usuario,
              userInfo: state.userInfo,
            ),
          );
        }

        if (state is BlocRegistroEstadoErrorGeneral) {
          showDialog<void>(
            context: context,
            builder: (context) => EscuelasDialog.fallido(
              onTap: () => Navigator.pop(context),
              content: Text(
                l10n.pageRegisterDialogContentText(
                  state.excepcion.tipoDeError.name,
                ),
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: BlocBuilder<BlocRegistro, BlocRegistroEstado>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.pw),
                        child: const EncabezadoDelRegistro(),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.pw),
                            child: const FormularioRegistro(),
                          ),
                          SizedBox(height: 40.ph),
                          const TextoDerechosReservados(),
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is BlocRegistroEstadoCargando)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
