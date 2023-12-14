import 'package:flutter/material.dart';

import '../components/view.dart';
import '../src/full_responsive/full_responsive_screen.g.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      mobile: ExampleView(
          name: 'mobile',
          color: Color.fromARGB(255, 98, 171, 231),
          width: 390,
          height: 844),
      mobileLandscape: ExampleView(
          name: 'mobile landscape',
          color: Color.fromARGB(255, 91, 137, 175),
          width: 844,
          height: 390),
      tablet: ExampleView(
          name: 'tablet',
          color: Color.fromARGB(255, 83, 180, 89),
          width: 1024,
          height: 1350),
      tabletLandscape: ExampleView(
          name: 'tablet landscape',
          color: Color.fromARGB(255, 67, 153, 78),
          width: 1350,
          height: 1024),
      desktop: ExampleView(
          name: 'desktop',
          color: Color.fromARGB(255, 212, 210, 86),
          width: 1620,
          height: 740),
    );
  }
}
