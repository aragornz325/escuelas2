// TODO(Juanjo): Completar con el resto de plantillas.
import 'dart:convert';

import 'package:escuelas_commons/manejo_de_calificaciones/valor_de_calificacion/valor_de_calificacion.dart';
import 'package:escuelas_server/src/generated/calificacion/calificacion_mensual.dart';
import 'package:escuelas_server/src/generated/curso/asignatura.dart';
import 'package:escuelas_server/src/generated/protocol.dart' as protocol;
import 'package:intl/intl.dart';

abstract class PlantillaEmailEscuelas {
  String html();
}

class PlantillaEmailCalificaciones implements PlantillaEmailEscuelas {
  PlantillaEmailCalificaciones({
    required this.nombre,
    required this.apellido,
    required this.curso,
    required this.calificaciones,
    required this.mes,
  });

  final String nombre;  
  final String apellido;
  final String curso;
  final String calificaciones;
  final int mes;

  @override
  String html() {
    final contenido = [
      header(nombre, apellido, curso),
      '<br>',
      buildTablaDeCalificaciones(calificaciones, mes),
      '<br>',
      footer,
    ].join('\n');

    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Correo Escuelas</title>
</head>
<body>
$contenido
</body>
</html>
''';
  }

  String buildTablaDeCalificaciones(calificaciones, int mes) {
    final Map<String,dynamic> calificaciones_ = jsonDecode(calificaciones);
    final mes_ = DateFormat('LLLL', 'es_AR').format(DateTime(2024,mes));

    StringBuffer buffer = StringBuffer('<table style="margin: auto;text-align: center;border: 0px;"> <caption><b>${mes_.replaceRange(0, 1, mes_[0].toUpperCase())}</b></caption> <tr> <th style="font-family: \'Nunito\';font-style: normal;font-weight: 600;font-size: 15px;line-height: 20px;text-align: center;color: #6d6d6d;">Asignatura</th> <th style="font-family: \'Nunito\';font-style: normal;font-weight: 600;font-size: 15px;line-height: 20px;text-align: center;color: #6d6d6d;">Nota</th> </tr>');

    for (var nombreAsignatura in calificaciones_.keys) {
      final calificacion = protocol.Calificacion.fromJson(calificaciones_[nombreAsignatura], protocol.Protocol());
      buffer.write(' <tr> <td style="border: 1px solid #1e1e1e;border-radius: 3px;font-family: Nunito;font-size: 18px;font-weight: 600;padding: 10px 20px !important;">$nombreAsignatura</td> <td style="font-family: \'Nunito\';font-style: normal;font-weight: 900;font-size: 18px;line-height: 27px;text-align: center;color: #000000;">${ValorDeCalificacionNumericaDecimal.values[calificacion.index].representacion}</td> </tr> ');
    }
    buffer.write(' </table>');
    return buffer.toString();
  } 
}

class PlantillaEmailCalificacionesMensuales implements PlantillaEmailEscuelas {
  PlantillaEmailCalificacionesMensuales({
    required this.nombre,
    required this.apellido,
    required this.curso,
    required this.asignaturas,
    required this.calificaciones,
  });

  final String nombre;  
  final String apellido;
  final String curso;
  final List<Asignatura> asignaturas;
  final List<CalificacionMensual> calificaciones;

  @override
  String html() {
    final contenido = [
      header(nombre, apellido, curso),
      '<br>',
      buildTablaDeCalificaciones(calificaciones),
      '<br>',
      footer,
    ].join('\n');

    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Correo Escuelas</title>
</head>
<body>
$contenido
</body>
</html>
''';
  }

  String buildTablaDeCalificaciones(List<CalificacionMensual> calificaciones) {
    final meses = calificaciones.map((e) => e.numeroDeMes).toSet().toList()..sort();
    final asignaturas = this.asignaturas;

    StringBuffer buffer = StringBuffer('<table style="margin: auto;text-align: center;border: 0px;"> <tr> <th style="font-family: \'Nunito\';font-style: normal;font-weight: 600;font-size: 15px;line-height: 20px;text-align: center;color: #6d6d6d;">Asignatura</th> ');

    for (final mes in meses) { 
      final nombreMes = DateFormat('LLLL', 'es_AR').format(DateTime(2024,mes));

      buffer.write('<th style="font-family: \'Nunito\';font-style: normal;font-weight: 600;font-size: 15px;line-height: 20px;text-align: center;color: #6d6d6d;">${nombreMes.replaceRange(0, 1, nombreMes[0].toUpperCase())}</th> ');
    }

    buffer.write('</tr> ');

    for (var asignatura in asignaturas) {
      buffer.write('<tr> <td style="border: 1px solid #1e1e1e;border-radius: 3px;font-family: Nunito;font-size: 18px;font-weight: 600;padding: 10px 20px !important;">${asignatura.nombre}</td> ');
      for (var mes in meses) {
        final calificacionMes = calificaciones.firstWhere((element) => element.calificacion?.asignaturaId == asignatura.id && element.numeroDeMes == mes);
        buffer.write('<td style="font-family: \'Nunito\';font-style: normal;font-weight: 900;font-size: 18px;line-height: 27px;text-align: center;color: #000000;">${calificacionMes.calificacion != null ? ValorDeCalificacionNumericaDecimal.values[calificacionMes.calificacion!.index].representacion : 'N/D'}</td> ');
      }
      buffer.write('</tr> ');
    }

    buffer.write(' </table>');
    return buffer.toString();
  } 
}

String header(String nombre, apellido, curso) => '''
<div id=":10j" class="ii gt" jslog="20277; u014N:xr6bB; 1:WyIjdGhyZWFkLWY6MTc4NDk0NDIyODgwNjI0OTk4NCJd; 4:WyIjbXNnLWY6MTc4NDk0NDIyODgwNjI0OTk4NCJd"><div id=":10i" class="a3s aiL msg6413164457249552155"><div class="adM">
</div><div style="background-color:transparent;margin:0;padding:0"><div class="adM">
    </div><table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:transparent">
        <tbody>
            <tr>
                <td>
                    <table class="m_6413164457249552155row-1" align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#ffffff;background-size:auto">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="m_6413164457249552155row-content m_6413164457249552155stack" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#ffffff;background-size:auto;color:#000000;width:700px" width="700">
                                        <tbody>
                                            <tr>
                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="100%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:55px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table class="m_6413164457249552155image_block" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                        <tbody><tr>
                                                            <td style="width:100%;padding-right:0px;padding-left:0px">
                                                                <div align="center" style="line-height:10px"><img src="https://ci3.googleusercontent.com/meips/ADKq_NaVp8QcnUfCq5qJJp87F-uHuX1zifqaneAHUhmo32n-uc9zGSwBeGQC45bSvEDp7N99Cbz8mPlDJo3VjCs7j-nJqmMIsZ6kiNdQrd1Z4AFhCdpOJWWN7sZky-2gfSKF03ppmZLvVRAiGAuDVc5Di43eVmscAaczr95foW7E8zL2CFn0lGBbq7vl_g=s0-d-e1-ft#https://cwpyccjwzfudnhvetaiz.supabase.co/storage/v1/object/public/imagenes/logoRM.png?t=2023-05-22T17%3A24%3A50.213Z" style="display:block;height:auto;border:0;width:139px;max-width:100%" width="139" alt="Image" title="Image" class="CToWUd" data-bit="iit"></div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td style="padding-left:10px;padding-right:10px;padding-top:5px">
                                                                <div style="font-family:Arial,sans-serif">
                                                                    <div style="font-family:'Nunito',Arial,'Helvetica Neue',Helvetica,sans-serif;font-size:24px;color:#0e112b;line-height:1.2">
                                                                        <p style="margin:0;text-align:center;font-size:24px">
                                                                            <span style="font-size:24px"><span>COLEGIO</span></span>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td style="padding-bottom:10px;padding-left:10px;padding-right:10px">
                                                                <div style="font-family:Arial,sans-serif">
                                                                    <div style="font-size:12px;font-family:'Nunito',Arial,'Helvetica Neue',Helvetica,sans-serif;color:#0e112b;line-height:1.5">
                                                                        <p style="margin:0;font-size:14px;text-align:center">
                                                                            <strong><span style="font-size:36px">REDEMPTORIS
                                                                                    MISSIO</span></strong>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#0e112b;background-size:auto">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="m_6413164457249552155row-content" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-radius:0;color:#000000;background-size:auto;width:555px" width="555">
                                        <tbody>
                                            <tr>
                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="33.333333333333336%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table width="100%" border="0" cellpadding="10" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td>
                                                                <div style="font-family:Nunito,Arial,sans-serif">
                                                                    <div style="font-size:12px;font-family:'Nunito',Arial,'Helvetica Neue',Helvetica,sans-serif;color:#ffffff;line-height:2">
                                                                        <p style="margin:0;font-size:16px;text-align:center">
                                                                            <span style="color:#ffffff"><a href="https://www.colegioredemptorismissio.com/" style="text-decoration:none;color:#eeeeee" rel="noopener" target="_blank" data-saferedirecturl="https://www.google.com/url?q=https://www.colegioredemptorismissio.com/&amp;source=gmail&amp;ust=1703815691719000&amp;usg=AOvVaw2JFNSpNqcTWf_hktmjbrEg"><span style="font-size:16px;text-decoration:none"><span>INSTITUCIÓN</span></span></a></span>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                                <td class="m_6413164457249552155column" width="33.333333333333336%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table width="100%" border="0" cellpadding="10" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td>
                                                                <div style="font-family:Nunito,Arial,sans-serif">
                                                                    <div style="font-size:12px;font-family:'Nunito',Arial,'Helvetica Neue',Helvetica,sans-serif;color:#ffffff;line-height:2">
                                                                        <p style="margin:0;font-size:16px;text-align:center">
                                                                            <span style="color:#ffffff"><a href="https://www.colegioredemptorismissio.com/planillas" style="text-decoration:none;color:#eeeeee" rel="noopener" target="_blank" data-saferedirecturl="https://www.google.com/url?q=https://www.colegioredemptorismissio.com/planillas&amp;source=gmail&amp;ust=1703815691719000&amp;usg=AOvVaw2hCU9xXLym0XD4svwFPtkE"><span style="font-size:16px"><span>INSCRIPCIÓN</span></span></a></span>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                                <td class="m_6413164457249552155column" width="33.333333333333336%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table width="100%" border="0" cellpadding="10" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td>
                                                                <div style="font-family:Nunito,Arial,sans-serif">
                                                                    <div style="font-size:12px;font-family:'Nunito',Arial,'Helvetica Neue',Helvetica,sans-serif;color:#ffffff;line-height:2">
                                                                        <p dir="ltr" style="margin:0;font-size:16px;text-align:center">
                                                                            <span style="font-size:16px;color:#ffffff"><a href="mailto:+colegio.rm.alumnos@gmail.com" style="text-decoration:none;color:#eeeeee" rel="noopener" target="_blank">CONTACTO</a></span>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#ffffff">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="m_6413164457249552155row-content m_6413164457249552155stack" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="color:#000000;width:700px" width="700">
                                        <tbody>
                                            <tr>
                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="100%" style="font-weight:400;text-align:left;padding-top:10px;vertical-align:middle;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="word-break:break-word">
                                                        <tbody><tr>
                                                            <td style="padding-bottom:5px;padding-left:0px;padding-right:0px;padding-top:15px">
                                                                <div style="font-family:sans-serif">
                                                                    <div style="font-size:12px;font-family:'Poppins',Arial,Helvetica,sans-serif;color:#000000;line-height:2">
                                                                        <div style="font-family:'Nunito';font-style:normal;font-weight:600;font-size:16px;line-height:22px;text-align:center;color:#979797">CALIFICACIONES MENSUALES</div>
                                                                        <div style="font-family:'Nunito';font-style:normal;font-weight:800;font-size:27px;line-height:37px;text-align:center;color:#0e112b">${nombre.toUpperCase()} ${apellido.toUpperCase()}</div>
                                                                        <div style="font-family:'Nunito';font-style:normal;font-weight:600;font-size:20px;line-height:27px;text-align:center;color:#0e112b">${curso.toUpperCase()}</div>
                                                                        <p style="margin:0;font-size:14px;text-align:center">
                                                                            &nbsp;</p>
                                                                      
                                                                        <p style="margin:0;font-size:14px;text-align:center">
                                                                            <span style="font-size:20px"></span></p>''';
String footer = '''<p></p>
                                                                        <p style="margin:0;font-size:14px;text-align:center">
                                                                            &nbsp;</p>
                                                                        <p style="margin:0;font-size:14px;text-align:center">
                                                                            <span style="font-size:20px">
                                                                                </span></p>                                                                            
                                                                        <p></p>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="m_6413164457249552155row-4" align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#ffffff">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="m_6413164457249552155row-content m_6413164457249552155stack" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="color:#000000;width:555px" width="555">
                                        <tbody>
                                            <tr>
                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="100%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table class="m_6413164457249552155image_block" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                        <tbody><tr>
                                                            <td style="width:100%;padding-right:0px;padding-left:0px">
                                                                <div align="center" style="line-height:10px"><img class="m_6413164457249552155big CToWUd a6T" src="https://ci3.googleusercontent.com/meips/ADKq_Nah9RgJyHujCuEBFNmX-56l4pxZyvyyumUKRIRoGClBBzUsAQ-tCZKX76W8UwfECVVoTK9PnzFDNPf3NxBPeDzsScG6cHxMynR4UR-9NHcV79-z4_Q3dA-wFyQG3Uiwf7Q44o21XBFHXiejwtR4u0aQwChy1gVITapnK2YJi_0xL-LkPTYkiATxh-HUNipdSg=s0-d-e1-ft#https://cwpyccjwzfudnhvetaiz.supabase.co/storage/v1/object/public/imagenes/nidus_banner.jpg?t=2023-04-26T16%3A57%3A05.450Z" style="display:block;height:auto;border:0;width:555px;max-width:100%" width="555" alt="Nidus Development" title="Nidus Development" data-bit="iit" tabindex="0"><div class="a6S" dir="ltr" style="opacity: 0.01; left: 942.484px; top: 1240.81px;"><div id=":10x" class="T-I J-J5-Ji aQv T-I-ax7 L3 a5q" title="Download" role="button" tabindex="0" aria-label="Download attachment " jslog="91252; u014N:cOuCgd,Kr2w4b,xr6bB; 4:WyIjbXNnLWY6MTc4NDk0NDIyODgwNjI0OTk4NCJd" data-tooltip-class="a1V" jsaction="JIbuQc:.CLIENT"><div class="akn"><div class="aSK J-J5-Ji aYr"></div></div></div></div></div>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#043d8a">
                        <tbody>
                            <tr>
                                <td>
                                    <table class="m_6413164457249552155row-content m_6413164457249552155stack" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-radius:0;color:#000000;width:555px" width="555">
                                        <tbody>
                                            <tr>
                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="100%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">
                                                    <table class="m_6413164457249552155row-content m_6413164457249552155stack" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-radius:0;color:#000000;width:555px" width="555">
                                                        <tbody>
                                                            <tr>
                                                                <td class="m_6413164457249552155column m_6413164457249552155column-1" width="100%" style="font-weight:400;text-align:left;padding-bottom:5px;padding-top:5px;vertical-align:top;border-top:0px;border-right:0px;border-bottom:0px;border-left:0px">

                                                                    <table width="100%" border="0" cellpadding="10" cellspacing="0" role="presentation" style="word-break:break-word">
                                                                        <tbody><tr>
                                                                            <td>
                                                                                <div style="font-family:sans-serif">
                                                                                    <div style="color:#eeeeee;font-size:12px;font-family:'Overpass','Poppins',Arial,Helvetica,sans-serif;line-height:2">
                                                                                        <p style="margin:0;text-align:center">
                                                                                            <span style="font-size:13px">Todos
                                                                                                los
                                                                                                derechos reservados. ©
                                                                                                Nidus Development
                                                                                                - Argentina</span>
                                                                                        </p>
                                                                                        <p style="margin:0;text-align:center;color:#81a1cc">
                                                                                            <span style="font-size:11px">Terms
                                                                                                &amp;
                                                                                                conditions | Contact Us
                                                                                                |
                                                                                                Unsuscribe</span>
                                                                                        </p>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody></table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table><div class="yj6qo"></div><div class="adL">
</div></div><div class="adL">


</div></div></div>
''';