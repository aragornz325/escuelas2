import 'package:escuelas_client/escuelas_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_client/module.dart';

part 'bloc_dashboard_estado.dart';
part 'bloc_dashboard_evento.dart';

/// {@template BlocDashboard}
/// Se encarga de manejar los procesos compartidos
/// por más de una página que ocurren dentro de dashboard.
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvento, BlocDashboardEstado> {
  /// {@macro BlocDashboard}
  BlocDashboard({
    required UserInfo infoUsuario,
    required Usuario usuario,
  }) : super(
          BlocDashboardEstadoInicial(
            usuario: usuario,
            infoUsuario: infoUsuario,
          ),
        );
}
