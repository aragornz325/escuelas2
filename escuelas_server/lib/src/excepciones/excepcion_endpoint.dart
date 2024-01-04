// import 'package:escuelas_server/src/generated/protocol.dart';

// /// Clase que define una serie de excepciones personalizadas con tipos
// /// predefinidos.
// abstract class Excepciones extends ExcepcionCustom {
//   /// Crea una excepción de solicitud incorrecta.
//   ///
//   /// Esta excepción se utiliza cuando una solicitud no es válida.
//   /// [titulo] y [mensaje] son opcionales y se utilizan para personalizar
//   /// el mensaje de error.
  
//   Excepciones.solicitudIncorrecta({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//     }) : super(
//           tipoDeError: TipoExcepcion.solicitudIncorrecta,
//           codigoError: 400,
//           titulo: titulo ?? 'Error Code: BAD_REQUEST',
//           mensaje: mensaje ??
//               'It seems that the request is not valid, please try again.',
//         );

//   /// Crea una excepción de no autorizado.
//   ///
//   /// Esta excepción se utiliza cuando un usuario no está autorizado para
//   /// acceder a un recurso. [titulo] y [mensaje] son opcionales y se utilizan
//   /// para personalizar el mensaje de error.
//   Excepciones.noAutorizado({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.noAutorizado,
//           codigoError: 401,
//           titulo: titulo ?? 'Error Code: UNAUTHORIZED',
//           mensaje: mensaje ??
//               'It seems that you are not authorized to access this resource, '
//                   'please check your credentials or try again later.',
//         );

//   /// Crea una excepción de prohibido.
//   ///
//   /// Esta excepción se utiliza cuando un usuario no está autorizado para
//   /// acceder a un recurso. [titulo] y [mensaje] son opcionales y se
//   /// utilizan para personalizar el mensaje de error.
//   Excepciones.prohibido({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.prohibido,
//           codigoError: 403,
//           titulo: titulo ?? 'Error Code: FORBIDDEN',
//           mensaje: mensaje ??
//               'It seems that you are not authorized to access this resource, '
//                   'please check your credentials or try again later.',
//         );

//   /// Crea una excepción de no encontrado.
//   ///
//   /// Esta excepción se utiliza cuando un recurso no se encuentra disponible.
//   /// [titulo] y [mensaje] son opcionales y se utilizan para personalizar
//   /// el mensaje de error.
//   Excepciones.noEncontrado({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.noEncontrado,
//           codigoError: 404,
//           titulo: titulo ?? 'Error Code: NOT_FOUND',
//           mensaje: mensaje ??
//               'It seems that the resource you are trying to access is not '
//                   'available at the moment, please try again later.',
//         );

//   /// Crea una excepción de sin conexión.
//   ///
//   /// Esta excepción se utiliza cuando el dispositivo no está conectado
//   /// a la red.
//   ///
//   /// [titulo] y [mensaje] son opcionales y se utilizan para personalizar
//   /// el mensaje de error.
//   Excepciones.sinConexion({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.sinConexion,
//           codigoError: 561,
//           titulo: titulo ?? 'Error Code: NO_CONNECTIVITY',
//           mensaje: mensaje ??
//               'It seems that your device is not connected to the network, '
//                   'please check your internet connectivity or try again later.',
//         );

//   /// Crea una excepción de parseo de datos.
//   ///
//   /// Esta excepción se utiliza cuando los datos no se pueden
//   /// analizar correctamente.
//   ///
//   /// [titulo] y [mensaje] son opcionales y se utilizan para
//   /// personalizar el mensaje de error.
//   Excepciones.parseo({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.parseo,
//           codigoError: 560,
//           titulo: titulo ?? 'Error Code: DATA_PARSING',
//           mensaje: mensaje ??
//               'It seems that the data you are trying to parse is not '
//                   'valid, please check your data and try again.',
//         );

//   /// Crea una excepción desconocida.
//   ///
//   /// Esta excepción se utiliza cuando el servidor no es accesible.
//   /// [titulo] y [mensaje] son opcionales y se utilizan para personalizar
//   /// el mensaje de error.
//   Excepciones.desconocido({
//     super.stackTrace,
//     String? titulo,
//     String? mensaje,
//   }) : super(
//           tipoDeError: TipoExcepcion.desconocido,
//           codigoError: 570,
//           titulo: titulo ?? 'Error Code: UNKNOWN',
//           mensaje: mensaje ??
//               'It seems that the server is not reachable at the moment, try '
//                   'again later, should the issue persist please reach out.',
//         );
// }
