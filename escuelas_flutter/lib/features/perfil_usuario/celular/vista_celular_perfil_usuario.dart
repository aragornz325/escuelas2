import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:escuelas_flutter/features/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/perfil_usuario/widgets/seccion_datos_personales.dart';
import 'package:escuelas_flutter/features/perfil_usuario/widgets/tarjeta_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/capitalize.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularPerfilUsuario}
/// Vista celular de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class VistaCelularPerfilUsuario extends StatelessWidget {
  /// {@macro VistaCelularPerfilUsuario}
  const VistaCelularPerfilUsuario({super.key});

  /// Dialog para confirmar la asignacion de un rol al usuario
  void _dialogAsignarRol(
    BuildContext context,
    InfoUsuario? usuario,
  ) {
    final colores = context.colores;

    final l10n = context.l10n;

    showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.confirmar(
        context: context,
        ancho: 260.pw,
        // TODO(Gon): Dar funcion asignar rol al usuario
        onTapConfirmar: () {},
        // TODO(Gon): Verificar el estilo de este widget, me parece que esta medio raro
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: colores.grisSC,
              fontSize: 16.pf,
              fontWeight: FontWeight.w600,
            ),
            children: <TextSpan>[
              TextSpan(
                text: l10n.pageRoleAssigmentDialogFirstText,
                style: TextStyle(
                  color: colores.grisSC,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: usuario?.nombre ?? '',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: l10n.pageRoleAssigmentDialogSecondText,
                style: TextStyle(
                  color: colores.grisSC,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '${usuario?.rol.name.toUpperCase()}?',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.router.pop(),
          child: Icon(
            Icons.arrow_back,
            color: colores.onBackground,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => context.router.pop(),
            child: Icon(
              Icons.more_vert,
              color: colores.onBackground,
              size: 25.sw,
            ),
          ),
          SizedBox(width: 10.pw),
        ],
        title: Text(
          l10n.pageRoleAssigmentPendingUsers,
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w800,
            fontSize: 16.pf,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
          builder: (context, state) {
            return Column(
              children: [
                const TarjetaPerfil(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.ph),
                  child: ElementoLista(
                    texto: Text(
                      capitalize(state.usuario?.rol.name ?? ''),
                      style: TextStyle(
                        color: colores.onSecondary,
                        fontSize: 13.pf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ancho: 340.pw,
                    altura: 50.ph,
                    widgetLateralDerecho: const Icon(Icons.arrow_drop_down),
                  ),
                ),
                const DatosPersonales(),
                SizedBox(height: 40.ph),
                // TODO(Gon): Estos botones solo se ven si se navega desde
                // asignacion de rol habria que aplicar una logica para decidir
                // cuando mostrarlo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EscuelasBoton.texto(
                      estaHabilitado: true,
                      onTap: () => Navigator.of(context).pop,
                      color: colores.error,
                      texto: l10n.commonDecline.toUpperCase(),
                      context: context,
                    ),
                    SizedBox(width: 20.ph),
                    EscuelasBoton.texto(
                      estaHabilitado: true,
                      onTap: () => _dialogAsignarRol(context, state.usuario),
                      color: colores.verdeConfirmar,
                      texto: l10n.commonConfirm.toUpperCase(),
                      context: context,
                    ),
                  ],
                ),
                SizedBox(height: 20.ph),
              ],
            );
          },
        ),
      ),
    );
  }
}
