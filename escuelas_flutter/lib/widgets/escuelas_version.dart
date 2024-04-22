import 'package:escuelas_flutter/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:shorebird_update_checker/shorebird_update_checker.dart';

class EscuelasVersion extends StatelessWidget {
  const EscuelasVersion({super.key});

  @override
  //TODO: traducir esto
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateController.init();
        print(updateController.isShorebirdAvailable);
      },
      child: UpdateButton(
        controller: updateController,
        updateAvailableWidget: (patchActual, patchNuevo) =>
            Text('Nueva actualización disponible ($patchNuevo)'),
        checkingForUpdatesWidget: const CircularProgressIndicator(),
        upToDateWidget: Text(
            'Versión: ${updateController.shorebirdCurrentPatchNumber ?? '-'}'),
      ),
    );
  }
}
