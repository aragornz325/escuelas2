import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class VistaCelularKyCEdicionUsuario extends StatelessWidget {
  const VistaCelularKyCEdicionUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      builder: (context, state) {
        if (state is BlocPerfilUsuarioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Container(
              width: 349.pw,
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(20.sw),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.ph,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.pw),
                      child: Text(
                        'DATOS PERSONALES',
                        style: TextStyle(
                          color: colores.tertiary,
                          fontSize: 13.pf,
                        ),
                      ),
                    ),
                    const Divider(height: .5),
                    KyCTextfield(
                      texto: 'Teléfono',
                      textfield: EscuelasTextfield.soloNumero(
                          onChanged: (p0) {},
                          context: context,
                          hintText: '',
                          controller: controllerTelefono),
                    ),
                    KyCTextfield(
                      texto: 'Mail',
                      textfield: EscuelasTextfield.email(
                        controller: controllerMail,
                        context: context,
                        hintText: '',
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KyCTextfield(
                          texto: 'Grupo sanguíneo',
                          textfield: EscuelasTextfield(
                            esPassword: false,
                            width: 147.pw,
                            hintText: '',
                            controller: controllerGrupoSanguineo,
                          ),
                        ),
                        SizedBox(width: 7.pw),
                        KyCTextfield(
                          texto: 'Edad',
                          textfield: EscuelasTextfield.soloNumero(
                            onChanged: (p0) {},
                            context: context,
                            hintText: '',
                            width: 147.pw,
                            controller: controllerEdad,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// {@template KyCTextfield}
/// Widget custom para el armado del kyc
/// {@endtemplate}
class KyCTextfield extends StatelessWidget {
  /// {@macro KyCTextfield}
  const KyCTextfield({
    required this.texto,
    required this.textfield,
    super.key,
  });

  /// Texto titulo del textfield
  final String texto;

  /// Textfield a recibir
  final Widget textfield;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.pw),
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 10.pf,
              color: colores.tertiary,
            ),
          ),
        ),
        textfield,
      ],
    );
  }
}
