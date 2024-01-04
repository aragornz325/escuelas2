import 'package:escuelas_server/env/env.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:serverpod/serverpod.dart';

class ServicioComunicaciones extends Servicio {
  
  final smtpServer = gmail(EnvDev.direccionEmailGmail, EnvDev.passwordEmailGmail);
  
  Future enviarEmail(
    Session session, {
    required List<String> mailsDestinatarios,
    required String asuntoDelCorreo,
    required String cuerpoHtmlDelCorreo,
  }) async {
    
    final message = Message()
      ..from = Address(EnvDev.direccionEmailGmail, 'Nidus Escuelas')
      ..recipients.add(mailsDestinatarios)
      ..subject = asuntoDelCorreo
      ..html = cuerpoHtmlDelCorreo;

    try {
      final sendReport = await send(message, smtpServer);
      logger.fine('Message sent: $sendReport');
    } on MailerException catch (e) {
      logger.shout('Message not sent.');
      final log = StringBuffer();
      for (var p in e.problems) {
        log.write('Problem: ${p.code}: ${p.msg}\n');
      }
      logger.shout(log);
    }
  }
}
