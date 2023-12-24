import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/widgets/pregunta_y_respuesta.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularKyc}
/// TODO(anyone): AGREGAR DOCUMENTACION.
/// {@endtemplate}
class VistaCelularKyc extends StatefulWidget {
  /// {@macro VistaCelularKyc}
  const VistaCelularKyc({super.key});

  @override
  State<VistaCelularKyc> createState() => _VistaCelularKycState();
}

class _VistaCelularKycState extends State<VistaCelularKyc> {
  final bool estaHabilitado = true;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulario de DOCENTE',
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w800,
            fontSize: 16.pf,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          if (state is BlocKycEstadoCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 40.ph),
            child: Column(
              children: [
                SizedBox(height: 20.ph),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.pw),
                  child: Text(
                    'Contesta estas preguntas sobre vos. Necesitamos esta'
                    ' información a modo de identificarte en tu solicitud.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.pf,
                    ),
                  ),
                ),
                SizedBox(height: 20.ph),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.opcionesKyc.map(
                          (e) => Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 30.ph),
                                child: PreguntaYRespuesta(id: e.id),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context
                      .read<BlocKyc>()
                      .add(const BlocKycEventoAgregarOpcion()),
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                  ),
                  label: Text(
                    'AGREGAR MATERIA',
                    style: TextStyle(
                      color: colores.onBackground,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.pf,
                    ),
                  ),
                ),
                SizedBox(height: 20.ph),
                EscuelasBoton.texto(
                  context: context,
                  // TODO(Gon): Cambiar esta logica a una mejor, xq no esta bueno inicializar el nombre en vacio
                  // TODO(Gon): Tambien ver xq si no esta esto rompe state.opcionesKyc.isNotEmpty
                  estaHabilitado: state.opcionesKyc.isNotEmpty &&
                      state.opcionesKyc[0].curso.nombre != '',
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(content: Text('a'));
                    },
                  ),
                  color: colores.grisDeshabilitado,
                  texto: 'SOLICITAR',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
