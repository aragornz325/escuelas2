import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

@RoutePage()
class PaginaEjemplo extends StatelessWidget {
  const PaginaEjemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return FullResponsiveApp(
      child: const Ejemplo(),
    );
  }
}

class Ejemplo extends StatefulWidget {
  const Ejemplo({super.key});

  @override
  State<Ejemplo> createState() => _EjemploState();
}

class _EjemploState extends State<Ejemplo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 60.ph,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: ElementoLista(
                titulo: 'Mati',
                widgetIzquierda: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://imgflip.com/s/meme/Smiling-Cat.jpg',
                  ),
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: ElementoLista(
              titulo: 'Topo',
              widgetPosterior: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
