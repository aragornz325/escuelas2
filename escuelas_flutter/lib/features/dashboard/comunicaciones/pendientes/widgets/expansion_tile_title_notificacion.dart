import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/card_usuario.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ExpansionTileTitleNotificacion}
/// Titulo del expansion tile del elemento notificacion pendiente,
/// que tiene los datos de los usuarios.
/// {@endtemplate}
class ExpansionTileTitleNotificacion extends StatelessWidget {
  /// {@macro ExpansionTileTitleNotificacion}
  const ExpansionTileTitleNotificacion({
    required this.docente,
    required this.alumno,
    super.key,
  });

  final Usuario? alumno;

  final Usuario? docente;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 5.pw,
                  bottom: 5.ph,
                ),
                child: Row(
                  children: [
                    CardUsuario(
                      urlImagenDePerfil: docente?.urlFotoDePerfil ?? '',
                      nombre: docente?.nombre ?? '',
                      apellido: docente?.apellido ?? '',
                    ),
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.pw),
                        child: Image.asset(
                          Assets.images.flechaLargaDerecha.path,
                          width: 20.sw,
                        ),
                      ),
                    ),
                    CardUsuario(
                      urlImagenDePerfil: alumno?.urlFotoDePerfil ?? '',
                      nombre: alumno?.nombre ?? '',
                      apellido: alumno?.apellido ?? '',
                    ),
                    SizedBox(width: 1.pw),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 283.pw,
                  child: Text(
                    DateTime.now().formatearFechaConHora(
                      context,
                    ),
                    style: TextStyle(
                      fontSize: 14.pf,
                      fontWeight: FontWeight.w400,
                      color: colores.grisDetalleFecha,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
