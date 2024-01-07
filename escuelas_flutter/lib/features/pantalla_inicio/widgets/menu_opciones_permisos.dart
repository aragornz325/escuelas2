import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template MenuOpcionesPermisos}
/// Muestra una lista de opciones de navegacion que el usuario ve segun
/// sus permisos
/// {@endtemplate}
class MenuOpcionesPermisos extends StatelessWidget {
  /// {@macro MenuOpcionesPermisos}
  const MenuOpcionesPermisos({super.key});

  Future<void> _showDialogError(BuildContext context) {
    final l10n = context.l10n;
    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.fallido(
        // TODO(anyone): Revisar si este container esta bien
        content: Column(
          children: [
            SizedBox(
              height: 20.ph,
            ),
            Center(
              child: Text(
                l10n.commonDialogError,
                style: TextStyle(fontSize: 18.pf),
              ),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocInicio, BlocInicioEstado>(
      listener: (context, state) {
        if (state is BlocInicioEstadoFallido) {
          _showDialogError(context);
        }
      },
      builder: (context, state) {
        if (state is BlocInicioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              ...state.listaEtiquetas.map(
                (etiqueta) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.ph)
                      .copyWith(bottom: 15.ph),
                  child: ElementoLista.menu(
                    nombreOpcion: etiqueta.titulo,
                    context: context,
                    onTap: () => etiqueta.redirigirAVista(context),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await client.usuario.enviarSolicitudRegistroAlumno(
                    usuarioPendiente: UsuarioPendiente(
                      idUserInfo: 0,
                      nombre: 'Gon Pendiente',
                      apellido: 'Rigoni Pendiente',
                      dni: '434242',
                      rolSolicitado: 1,
                      estadoDeSolicitud: EstadoDeSolicitud.pendiente,
                    ),
                    comisionDeCurso: ComisionDeCurso(
                      nombre: 'cursillo',
                      idCurso: 13,
                      anioLectivo: 2024,
                      estudiantes: [],
                      ultimaModificacion: DateTime.now(),
                      fechaCreacion: DateTime.now(),
                    ),
                  );
                  await client.usuario.enviarSolicitudRegistroDocente(
                    usuarioPendiente: UsuarioPendiente(
                      idUserInfo: 0,
                      nombre: 'Gon Pendiente',
                      apellido: 'Rigoni Pendiente',
                      dni: '434242',
                      rolSolicitado: 1,
                      estadoDeSolicitud: EstadoDeSolicitud.pendiente,
                    ),
                    asignaturasASolicitar: [
                      Asignatura(
                        idCurso: 1,
                        nombre: 'asd',
                        docentes: [],
                        ultimaModificacion: DateTime.now(),
                        fechaCreacion: DateTime.now(),
                      ),
                    ],
                  );
                },
                child: Text('solicitar'),
              ),
            ],
          );
        }
      },
    );
  }
}
