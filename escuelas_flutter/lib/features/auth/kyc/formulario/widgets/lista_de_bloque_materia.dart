// import 'package:escuelas_flutter/extensiones/extensiones.dart';
// import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
// import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/boton_eliminar_opcion.dart';
// import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
// import 'package:escuelas_flutter/theming/base.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:full_responsive/full_responsive.dart';

// /// {@template ListaDeBloqueMateria}
// /// Lista de bloques de materias donde se puede elegir año y materia
// /// {@endtemplate}
// class ListaDeBloqueMateria extends StatelessWidget {
//   /// {@macro ListaDeBloqueMateria}
//   const ListaDeBloqueMateria({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colores = context.colores;

//     return Expanded(
//       child: SingleChildScrollView(
//         child: BlocBuilder<BlocKyc, BlocKycEstado>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 ...state.opcionesFormulario.map(
//                   (e) => Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 30.ph),
//                         child: BloqueMateria(id: e.id),
//                       ),
//                       if (state.opcionesFormulario.length > 1)
//                         BotonEliminarOpcion(idBloque: e.id),
//                       if (state.opcionesFormulario.length > 1 &&
//                           e.id != state.opcionesFormulario.length)
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.pw),
//                           child: Divider(color: colores.grisDeshabilitado),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
