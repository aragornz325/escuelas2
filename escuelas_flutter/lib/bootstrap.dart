import 'dart:async';
import 'dart:developer';

import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/one_signal/one_signal_servicio.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shorebird_update_checker/shorebird_update_checker.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Controlador de actualizaciones
late final UpdateController updateController;

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String hostUrl,
  required String entorno,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  /// One Signal(push notifications)
  await OneSignalServicio.inicializarOneSignal();

  /// Se instancia el objeto de la base de datos local Isar
  if (!kIsWeb) {
    await IsarServicio.abrirDB();
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // inicializador del cliente
  await inicializarClienteServerpod(
    hostUrl: hostUrl,
    entorno: entorno,
  );

  const updateCheckerConfig = UpdateCheckerConfig(
    iOSAppId: 'com.sorpi.pruebas-flutter-sorpi21',
    androidAppId: 'com.example.verygoodcore.escuelas_flutter',
    enableAppStoreUpdateChecker: false,
    forceShorebirdUpdate: true,
  );
  updateController =
      UpdateController(currentVersion: '', config: updateCheckerConfig);
  updateController.init().then((value) => print('initialized update'));

  runApp(await builder());
}

/// Enum que especifica el entorno de desarrollo a utilizar para pasarselo
/// por parametro a la funcion del initializeServerpodClient.
enum EntornosDeDesarrollo {
  staging,
  development,
  production,
}
