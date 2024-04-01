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
  const FormularioDePerfilUsuario({
    required this.dniUsuario,
    required this.idUsuario,
    super.key,
  });

  /// dni del usuario
  final String dniUsuario;

  final int idUsuario;

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

  Future<void> _onEditarPassword(
    BuildContext context, {
    required String dniUsuario,
    required int idUsuario,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocEditarPerfil>(),
        child: DialogEditarPassword(
          idUsuario: idUsuario,
          dniUsuario: dniUsuario,
        ),
      ),
    );
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
            Center(
              child: EscuelasBoton.texto(
                estaHabilitado: true,
                onTap: () => _onEditarPassword(
                  context,
                  dniUsuario: widget.dniUsuario,
                  idUsuario: widget.idUsuario,
                ),
                color: colores.amarilloCuartoFalta,
                texto: 'Cambiar contraseña',
                context: context,
              ),
            ),
            SizedBox(height: max(5.ph, 5.sh)),
          ],
        ),
      ),
    );
  }
}

class DialogEditarPassword extends StatefulWidget {
  const DialogEditarPassword({
    required this.dniUsuario,
    required this.idUsuario,
    super.key,
  });

  final String dniUsuario;
  final int idUsuario;
  @override
  State<DialogEditarPassword> createState() => _DialogEditarPasswordState();
}

class _DialogEditarPasswordState extends State<DialogEditarPassword> {
  late TextEditingController _controllerNuevaPassword = TextEditingController();
  bool requerirCambioPassword = true;

  @override
  void initState() {
    _controllerNuevaPassword = TextEditingController(text: widget.dniUsuario);
    super.initState();
  }

  @override
  void dispose() {
    _controllerNuevaPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EscuelasDialog.solicitudDeAccion(
      titulo: 'Cambiar contraseña',
      context: context,
      estaHabilitado: _controllerNuevaPassword.text.length > 8,
      // &&
      //     _controllerNuevaPassword.text == _controllerRepetirNuevaPassword.text,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        context.read<BlocEditarPerfil>().add(
              BlocEditarPerfilEventoEditarPassword(
                conRequerimientoDeCambioDePassword: requerirCambioPassword,
                nuevaPassword: _controllerNuevaPassword.text,
                idUsuario: widget.idUsuario,
              ),
            );
      },
      content: Column(
        children: [
          EscuelasTextFieldPassword(
            controller: _controllerNuevaPassword,
            onValidate: (v) {},
            onChanged: (v) => setState(() {}),
          ),
          SizedBox(height: max(5.ph, 5.sh)),
          Row(
            children: [
              Text('Requerir cambio de password'),
              Checkbox(
                value: requerirCambioPassword,
                onChanged: (v) {
                  setState(() {
                    requerirCambioPassword = v!;
                  });
                },
              ),
            ],
          )
          // EscuelasTextFieldPassword(
          //   controller: _controllerRepetirNuevaPassword,
          //   onValidate: (v) {},
          //   onChanged: (v) => setState(() {}),
          // ),
        ],
      ),
    );
  }
}
