import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BottomSheetFiltrado}
/// BottomSheet para filtrar por nombre, donde
/// muestra una lista de usuarios para asignar o agregar.
/// dependiendo de si es para asignar o agregar.
/// y tiene un buscador donde podes filtrar por nombre del usuario.
/// {@endtemplate}
class BottomSheetFiltrado extends StatefulWidget {
  /// {@macro BottomSheetFiltrado}
  const BottomSheetFiltrado({
    required this.idRol,
    this.esAsignarDocente = false,
    super.key,
  });

  /// Id del rol a filtrar en el buscador.
  final int idRol;

  /// Indica si es para asignar un docente o agregar un alumno a una comision.
  final bool esAsignarDocente;

  @override
  State<BottomSheetFiltrado> createState() => _BottomSheetFiltradoState();
}

class _BottomSheetFiltradoState extends State<BottomSheetFiltrado> {
  /// Controller para filtrar por nombre.
  final _controllerNombre = TextEditingController();

  /// FocusNode para el campo de texto.
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<BlocGestionDeComision>().add(
          BlocGestionDeComisionEventoFiltrarPorNombre(
            idRol: widget.idRol,
          ),
        );
  }

  @override
  void dispose() {
    _controllerNombre.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Dialogo para asignar un docente a una comision.
  void _dialogAsignarDocente(Usuario usuario) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocGestionDeComision>(),
        child: DialogConfirmarDocenteAsignatura(
          docente: usuario,
        ),
      ),
    );
  }

  /// Dialogo para agregar un alumno a una comision.
  void _dialogAgregarAlumno(Usuario usuario) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocGestionDeComision>(),
        child: DialogConfirmarAgregarAlumnoAComision(
          usuario: usuario,
        ),
      ),
    );
  }

  /// Funcion para asignar un docente a una comision o agregar un alumno a una
  /// comision.
  void _funcionAsignarOAgregar(Usuario usuario) {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      widget.esAsignarDocente
          ? _dialogAsignarDocente(usuario)
          : _dialogAgregarAlumno(usuario);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return SizedBox(
      height: 75.hp,
      child: Column(
        children: [
          Container(
            height: max(20.ph, 20.sh),
            width: double.infinity,
            color: colores.secondary,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: max(5.ph, 5.sh)),
                width: 50.pw,
                height: max(2.5.ph, 2.5.sh),
                decoration: BoxDecoration(
                  color: colores.onBackground,
                  borderRadius: BorderRadius.circular(25.sw),
                ),
              ),
            ),
          ),
          SizedBox(
            height: max(50.ph, 50.sh),
            child: Center(
              child: EscuelasTextfield(
                focusNode: _focusNode,
                fillColor: colores.background,
                hintText: l10n.commonSearchName,
                controller: _controllerNombre,
                prefixIcon: const Icon(
                  Icons.search,
                ),
                esPassword: false,
                onChanged: (value) {
                  if (value.isEmpty) {
                    context.read<BlocGestionDeComision>().add(
                          BlocGestionDeComisionEventoFiltrarPorNombre(
                            idRol: widget.esAsignarDocente ? 2 : 1,
                          ),
                        );
                  }
                  context.read<BlocGestionDeComision>().add(
                        BlocGestionDeComisionEventoFiltrarPorNombre(
                          idRol: widget.esAsignarDocente ? 2 : 1,
                          nombre: value,
                        ),
                      );
                },
              ),
            ),
          ),
          const Divider(height: 0),
          BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
            builder: (context, state) {
              if (state.usuarios.isEmpty) {
                return GestureDetector(
                  onTap: _focusNode.unfocus,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.groups_3_outlined,
                          size: 100.pw,
                          color: colores.secondary,
                        ),
                        Text(
                          l10n.pageAcademicCommunityNoUsersToShow,
                          style: TextStyle(
                            color: colores.secondary,
                            fontSize: 16.pf,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: state.usuarios
                        .map(
                          (usuario) => ElementoLista(
                            colorFondo: colores.background,
                            widgetLateralIzquierdo: Container(
                              width: 30.sw,
                              height: 30.sw,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                usuario.urlFotoDePerfil,
                                errorBuilder: (context, error, stackTrace) =>
                                    CircleAvatar(
                                  backgroundColor: colores.secondary,
                                ),
                              ),
                            ),
                            texto: Text(
                              usuario.nombre,
                              style: TextStyle(
                                fontSize: 16.pf,
                                fontWeight: FontWeight.w700,
                                color: colores.onBackground,
                              ),
                            ),
                            onTap: () => _funcionAsignarOAgregar(usuario),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
