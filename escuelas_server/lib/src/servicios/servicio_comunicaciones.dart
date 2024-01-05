import 'package:escuelas_server/env/env.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/utils/constants.dart';
import 'package:mailer/mailer.dart';
import 'package:serverpod/serverpod.dart';

class ServicioComunicaciones extends Servicio {
  
  Future<RespuestaMailer> enviarEmail(
    Session session, {
    required String direccionEmailDestinatario,
    required String asuntoDelCorreo,
    required String contenidoHtmlDelCorreo,
  }) async {
    final RespuestaMailer respuesta = RespuestaMailer(
      direccionEmailDestinatario: direccionEmailDestinatario,
      asuntoDelCorreo: asuntoDelCorreo,
      contenidoHtmlDelCorreo: contenidoHtmlDelCorreo,
      huboUnError: false,
    );

    final message = Message()
      ..from = Address(EnvDev.direccionEmailGmail, nombreEnCorreosElectronicos)
      ..recipients.add(direccionEmailDestinatario)
      ..subject = asuntoDelCorreo
      ..html = contenidoHtmlDelCorreo;

    try {
      final sendReport = await send(message, smtpServer);
      respuesta
        ..conexionAbierta = sendReport.connectionOpened
        ..comienzoEnvioDelCorreo = sendReport.messageSendingStart
        ..finalizacionDeEnvioDelCorreo = sendReport.messageSendingEnd;
      logger.fine(sendReport);
    } on MailerException catch (e) {
      final problemas = StringBuffer();
      for (var p in e.problems) {
        problemas.write('Problem: ${p.code}: ${p.msg}\n');
      }
      respuesta
        ..huboUnError = true
        ..error = e.message
        ..problemas = problemas.toString();
      logger.shout('Message not sent.');
      logger.shout(problemas);
    }

    return respuesta;
  }
}
