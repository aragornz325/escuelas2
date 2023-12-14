import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

import 'sizes.dart';

class ExampleView extends StatelessWidget {
  const ExampleView(
      {Key? key,
      required this.name,
      required this.color,
      required this.height,
      required this.width})
      : super(key: key);

  final int height;
  final int width;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizeInfoWidget(),
            Text('($name view: $width x $height)'),
            Container(
              color: color,
              width: 350.pw,
              height: 200.ph,
              child: Center(
                child: Text(
                    '350.pw x 200.ph (${350.pw.truncateToDouble()} x ${200.ph.truncateToDouble()})',
                    style: TextStyle(
                        fontSize: 20.pf,
                        color: color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)),
              ),
            ),
            Container(
              color: color.withAlpha(180),
              width: 200.sw,
              height: 200.sh,
              child: Center(
                child: Text('200.sw x 200.sh (200 x 200)',
                    style: TextStyle(
                        fontSize: 20.sf,
                        color: color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)),
              ),
            ),
            Container(
              color: color.withAlpha(80),
              width: 100.wp,
              height: 10.hp,
              child: Center(
                child: Text(
                    '100.wp x 10.hp (${100.wp.truncateToDouble()} x ${10.hp.truncateToDouble()})',
                    style: TextStyle(
                        fontSize: 20.sf,
                        color: color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
