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
class VistaCelularKyc extends StatelessWidget {
  /// {@macro VistaCelularKyc}
  const VistaCelularKyc({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulario de DOCENTE',
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w900,
            fontSize: 16.pf,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: 40.ph),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20.ph),
                    const Text(
                      'Contesta estas preguntas sobre vos. Necesitamos esta'
                      ' información a modo de identificarte en tu solicitud.',
                    ),
                    SizedBox(height: 20.ph),
                    const PreguntaYRespuesta(
                      titulo: '¿De qué año es tu materia?',
                    ),
                  ],
                ),
                EscuelasBoton.texto(
                  context: context,
                  estaHabilitado: true,
                  onTap: () {},
                  color: colores.grisDeshabilitado,
                  texto: 'CONTINUAR',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
