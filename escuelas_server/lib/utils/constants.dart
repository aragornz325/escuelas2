import 'package:escuelas_server/env/env.dart';
import 'package:mailer/smtp_server.dart';

/// Instancia de servidor SMTP para mailer.
final SmtpServer smtpServer = gmail(EnvDev.direccionEmailGmail, EnvDev.passwordEmailGmail);

/// Nombre que aparecerá en los correos electrónicos enviados mediante el mailer.
const nombreEnCorreosElectronicos = 'Nidus Escuelas';

const asuntoDeCorreoVerificacionDeCuenta = 'Código de validación';

const asuntoDeCorreoRecuperacionDePassword = 'Código de validación';

const asuntoDeCorreoSolicitudDeCargaDeCalificacionesMensuales = 'Hay un nuevo pedido de calificaciones.';