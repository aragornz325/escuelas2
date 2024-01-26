import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextX on BuildContext {
  bool tienePermiso(Enum permiso) {
    return read<BlocDashboard>().state.usuario.tienePermisos(permiso);
  }
}
