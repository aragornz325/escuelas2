import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularEspera}
/// Vista celular de la pantalla 'Espera'
/// {@endtemplate}
class VistaCelularEspera extends StatelessWidget {
  /// {@macro VistaCelularEspera}
  const VistaCelularEspera({
    super.key,
  });

  /// Muestra dialog para permitirle al usuario cerrar sesion.
  Future<void> _showDialogCerrarSesion(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocKyc>(),
        child: BlocListener<BlocKyc, BlocKycEstado>(
          listener: (context, state) {
            if (state is BlocKycEstadoCerrarSesionExitoso) {
              Navigator.pop(context);
              context.replaceRoute(const RutaLogin());
            }
          },
          child: EscuelasDialog.logOut(
            context: context,
            onCerrarSesion: () =>
                context.read<BlocKyc>().add(BlocKycEventoCerrarSesion()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.sh,
              width: 50.sw,
              // TODO(ANyone): Agregar logo de empresa o ver que va aca
              decoration: BoxDecoration(
                color: colores.grisClaroSombreado,
              ),
            ),
            SizedBox(height: 100.ph),
            SizedBox(
              width: 250.pw,
              child: Text(
                l10n.pageKycAwaitApprovalDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.pf,
                ),
              ),
            ),
            SizedBox(height: 200.ph),
            InkWell(
              onTap: () => _showDialogCerrarSesion(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colores.azul,
                  borderRadius: BorderRadius.circular(50.sw),
                ),
                child: Text(
                  l10n.drawerLogOut.toUpperCase(),
                  style: TextStyle(
                    color: colores.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await client.usuario.responderSolicitudDeRegistro(
                  estadoDeSolicitud: EstadoDeSolicitud.aprobado,
                  idUsuarioPendiente:
                      33, // TODO(ANYONE): Agregar ID usuario pendiente
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colores.azul,
                  borderRadius: BorderRadius.circular(50.sw),
                ),
                child: Text(
                  l10n.pageKycAwaitApprovalAcceptUser,
                  style: TextStyle(
                    color: colores.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
