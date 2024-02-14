import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SeleccionarAsignaturaParaDocente}
/// Dialogo para seleccionar una asignatura por comision
/// {@endtemplate}
class SeleccionarAsignaturaParaDocente extends StatefulWidget {
  /// {@macro SeleccionarAsignaturaParaDocente}
  const SeleccionarAsignaturaParaDocente({
    required this.idUsuario,
    super.key,
  });

  /// Id del usuario
  final int idUsuario;

  @override
  State<SeleccionarAsignaturaParaDocente> createState() =>
      _SeleccionarAsignaturaParaDocenteState();
}

class _SeleccionarAsignaturaParaDocenteState
    extends State<SeleccionarAsignaturaParaDocente> {
  /// Id de la asignatura seleccionada
  int? idAsignaturaSeleccionada;

  /// Id de la comision seleccionada
  int? idComisionSeleccionada;
  Asignatura? asignatura;
  bool eligioOpcion = false;
  ComisionDeCurso? comision;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog(
      estaHabilitado:
          idAsignaturaSeleccionada != null && idComisionSeleccionada != null,
      onTapConfirmar: () {
        context.read<BlocPerfilUsuario>().add(
              BlocPerfilUsuarioEventoAgregarAsignatura(
                asignatura: asignatura,
                comision: comision,
                idUsuario: widget.idUsuario,
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
      content: BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
        builder: (context, state) {
          int idCursoSegunComision(int idComision) {
            return state.listaComisiones
                    .firstWhere((comision) => comision.id == idComision)
                    .curso
                    ?.id ??
                0;
          }

          /// Lista de asignaturas que pertenecen al curso elegido que son
          /// convertidas en [EscuelasDropdownOption].
          final listaAsignaturasAsociadasAlCursoElegido =
              idComisionSeleccionada != null
                  ? state.listaAsignaturas
                      .where(
                        (asignatura) =>
                            asignatura.idCurso?.contains(
                              idCursoSegunComision(
                                idComisionSeleccionada!,
                              ),
                            ) ??
                            false,
                      )
                      .map(
                        (asignatura) => EscuelasDropdownOption(
                          value: asignatura.id ?? 0,
                          title: asignatura.nombre,
                        ),
                      )
                      .toList()
                  : <EscuelasDropdownOption<int>>[];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.ph),
                child: Text(
                  l10n.pageKycFormWhichGradeIsYourSubject,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.pf,
                  ),
                ),
              ),
              FormularioDropdown(
                lista: state.opcionesComisiones,
                listaOpcionesSeleccionadas: (opcion) => setState(() {
                  comision = state.listaComisiones
                      .firstWhere((element) => element.id == opcion.value);
                  idComisionSeleccionada = opcion.value;
                  eligioOpcion = true;
                }),
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
                hintText: eligioOpcion &&
                        listaAsignaturasAsociadasAlCursoElegido.isEmpty
                    ? l10n.pageKycNoSubjectsRelated
                    : null,
                enabled: eligioOpcion &&
                    listaAsignaturasAsociadasAlCursoElegido.isNotEmpty,
                lista:
                    eligioOpcion ? listaAsignaturasAsociadasAlCursoElegido : [],
                listaOpcionesSeleccionadas: (opcion) => setState(() {
                  idAsignaturaSeleccionada = opcion.value;
                  asignatura = state.listaAsignaturas.firstWhere(
                    (element) => element.id == opcion.value,
                  );
                }),
              ),
            ],
          );
        },
      ),
      titulo: l10n.pageKycFormChooseSubject,
    );
  }
}
