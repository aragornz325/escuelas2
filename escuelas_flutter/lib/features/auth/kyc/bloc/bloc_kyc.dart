import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_kyc_estado.dart';
part 'bloc_kyc_evento.dart';

/// {@template BlocKyc}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocKyc extends Bloc<BlocKycEvento, BlocKycEstado> {
  /// {@macro BlocInicio}
  BlocKyc(): super(const BlocKycEstadoInicial()) {
  }
}