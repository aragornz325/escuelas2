import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template _FormularioDePerfilUsuario}
/// Formulario para editar el perfil.
/// {@endtemplate}
class FormularioDePerfilUsuario extends StatefulWidget {
  /// {@macro _FormularioDePerfilUsuario}
  const FormularioDePerfilUsuario({super.key});

  @override
  State<FormularioDePerfilUsuario> createState() =>
      _FormularioDePerfilUsuarioState();
}

class _FormularioDePerfilUsuarioState extends State<FormularioDePerfilUsuario> {
  /// Controller del telefono
  final _controllerTelefono = TextEditingController();

  /// Controller del Email
  final _controllerEmail = TextEditingController();

  /// Controller del Factor Sanguineo
  final _controllerFactorSanguineo = TextEditingController();

  /// Controller del Edad
  final _controllerEdad = TextEditingController();

  /// Controller del Nombre
  final _controllerNombreTutor = TextEditingController();

  /// Controller del Apellido
  final _controllerApellidoTutor = TextEditingController();

  /// Controller del vinculo entre alumno y tutor.
  final _controllerVinculo = TextEditingController();

  /// Controller del Email del tutor.
  final _controllerEmailTutor = TextEditingController();

  /// Controller del Telefono del tutor.
  final _controllerTelefonoTutor = TextEditingController();

  /// Controller de las observaciones.
  final _controllerObservaciones = TextEditingController();

  /// key del form para las validaciones
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllerTelefono.dispose();
    _controllerEmail.dispose();
    _controllerFactorSanguineo.dispose();
    _controllerEdad.dispose();
    _controllerNombreTutor.dispose();
    _controllerApellidoTutor.dispose();
    _controllerVinculo.dispose();
    _controllerEmailTutor.dispose();
    _controllerTelefonoTutor.dispose();
    _controllerObservaciones.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: max(10.ph, 10.sh)),
            Text(
              l10n.commonPhone,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloNumero(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.secondary,
              ),
              maxLines: 1,
              controller: _controllerTelefono,
              hintText: l10n.commonPhone,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          telefono: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonEmail,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.email(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.secondary,
              ),
              maxLines: 1,
              controller: _controllerEmail,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          email: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.commonBloodFactor,
                        style: TextStyle(
                          fontSize: 13.pf,
                          fontWeight: FontWeight.w700,
                          color: colores.onBackground,
                        ),
                      ),
                      EscuelasTextfield.letrasYNumerosConIcono(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sw),
                        ),
                        borderSide: BorderSide(
                          color: colores.grisDeshabilitado,
                        ),
                        hintText: l10n.commonBloodFactor,
                        suffixIcon: const SizedBox.shrink(),
                        onValidate: (value) {},
                        controller: _controllerFactorSanguineo,
                        context: context,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            context.read<BlocEditarPerfil>().add(
                                  BlocEditarPerfilEventoGuardarCambios(
                                    factorSanguineo: v,
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.pw),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.commonAge,
                        style: TextStyle(
                          fontSize: 13.pf,
                          fontWeight: FontWeight.w700,
                          color: colores.onBackground,
                        ),
                      ),
                      EscuelasTextfield.soloNumero(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sw),
                        ),
                        borderSide: BorderSide(
                          color: colores.grisDeshabilitado,
                        ),
                        maxLines: 1,
                        hintText: l10n.commonAge,
                        controller: _controllerEdad,
                        context: context,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            context.read<BlocEditarPerfil>().add(
                                  BlocEditarPerfilEventoGuardarCambios(
                                    edad: v,
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            Text(
              l10n.commonEmergencyContact,
              style: TextStyle(
                fontSize: 14.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonName,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloLetrasConIcono(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              hintText: l10n.commonName,
              suffixIcon: const SizedBox.shrink(),
              onValidate: (value) {},
              controller: _controllerNombreTutor,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          nombreTutor: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonLastname,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloLetrasConIcono(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              hintText: l10n.commonLastname,
              suffixIcon: const SizedBox.shrink(),
              onValidate: (value) {},
              controller: _controllerApellidoTutor,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          apellidoTutor: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonBond,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloLetrasConIcono(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              hintText: l10n.commonBond,
              suffixIcon: const SizedBox.shrink(),
              onValidate: (value) {},
              controller: _controllerVinculo,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          vinculo: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonPhone,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloNumero(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              maxLines: 1,
              controller: _controllerTelefonoTutor,
              hintText: l10n.commonPhone,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          telefonoTutor: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonEmail,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.email(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              maxLines: 1,
              controller: _controllerEmailTutor,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          emailTutor: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonObservations,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloLetrasConIcono(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.grisDeshabilitado,
              ),
              maxLines: 3,
              hintText: l10n.commonObservations,
              suffixIcon: const SizedBox.shrink(),
              onValidate: (value) {},
              controller: _controllerObservaciones,
              context: context,
              onChanged: (v) {
                if (v.isNotEmpty) {
                  context.read<BlocEditarPerfil>().add(
                        BlocEditarPerfilEventoGuardarCambios(
                          observaciones: v,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: max(5.ph, 5.sh)),
          ],
        ),
      ),
    );
  }
}
