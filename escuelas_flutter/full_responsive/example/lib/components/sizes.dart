import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class SizeInfoWidget extends StatelessWidget {
  const SizeInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      "${size.width}x${size.height}",
      style: TextStyle(fontSize: 25.pf),
    );
  }
}
