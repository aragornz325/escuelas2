import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';

part 'bloc_administrar_plantillas.estado.dart';
part 'bloc_administrar_plantillas_evento.dart';

class BlocAdministrarPlantillas extends Bloc<BlocAdministrarPlantillasEvento,
    BlocAdministrarPlantillasEstado> {
  BlocAdministrarPlantillas()
      : super(const BlocAdministrarPlantillasEstadoInicial()) {}
}
