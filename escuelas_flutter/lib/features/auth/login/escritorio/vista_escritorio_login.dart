import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:flutter/material.dart';

import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';

const _googleServerClientId =
    '554988659961-utff4q26sh4e256ghmn986b90gutpqqg.apps.googleusercontent.com';

//! TODO(Anyone): cambiar por pagina de login escritorio
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        child: Container(
          width: 260,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///
              SignInWithGoogleButton(
                caller: client.modules.auth,
                serverClientId: _googleServerClientId,
                redirectUri: Uri.parse('http://localhost:8082/googlesignin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
