import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/widgets/menu_opciones_permisos.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularInicio}
/// Vista inicial de celular en la sección de Inicio,
/// donde se encuentran las distintas opciones de redireccion
/// de acuerdo a los permisos del usuario.
/// {@endtemplate}

class VistaCelularInicio extends StatefulWidget {
  /// {@macro VistaCelularInicio}
  const VistaCelularInicio({super.key});

  @override
  State<VistaCelularInicio> createState() => _VistaCelularInicioState();
}

class _VistaCelularInicioState extends State<VistaCelularInicio> {
  /// Muestra dialog de exito al cambiar la contraseña.
  Future<void> _showDialogExitoAlCambiarContrasenia(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.exitoso(
        context: context,
        onTap: () => Navigator.of(context).pop(),
        content: Column(
          children: [
            SizedBox(height: 20.ph),
            Center(
              child: Text(
                l10n.pageHomeChangePasswordSuccess,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.pf,
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra dialog de exito al cambiar el DNI.
  Future<void> _showDialogExitoAlCambiarDNI(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    setState(() => _dialogAbierto = true);

    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.exitoso(
        context: context,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        content: Column(
          children: [
            SizedBox(height: 20.ph),
            Center(
              child: Text(
                l10n.pageHomeChangeDNISuccess,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.pf,
                  color: colores.onBackground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra dialog de error
  Future<void> _showDialogError(
    BuildContext context, {
    required String error,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.fallido(
        content: Column(
          children: [
            SizedBox(height: 20.ph),
            Center(
              child: Text(
                error,
                style: TextStyle(fontSize: 18.pf),
              ),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Es para saber si ya se abrio dialog
  bool _dialogAbierto = false;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<BlocDashboard, BlocDashboardEstado>(
      listener: (context, state) {
        if (state is BlocDashboardEstadoExitosoAlCambiarLaContrasenia) {
          _showDialogExitoAlCambiarContrasenia(context);
        }
        if (state is BlocDashboardEstadoExitosoAlCambiarElDNI &&
            !_dialogAbierto) {
          _showDialogExitoAlCambiarDNI(context);
        }
        if (state is BlocDashboardEstadoFallido) {
          _showDialogError(
            context,
            error: state.excepcion?.tipoDeError.name ?? l10n.commonDialogError,
          );
        }
      },
      child: const MenuOpcionesPermisos(),
    );
  }
}
