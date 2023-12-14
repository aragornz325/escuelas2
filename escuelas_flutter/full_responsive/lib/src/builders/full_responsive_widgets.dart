import 'dart:async';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:full_responsive/src/builders/templates/full_responsive_app.dart';
import 'package:full_responsive/src/builders/templates/full_responsive_screen.dart';
import 'package:full_responsive/src/exceptions/malformed_pubspec_yaml.dart';
import 'package:glob/glob.dart';
import 'package:mustachex/mustachex.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

class FullResponsiveWidgetsBuilder extends Builder {
  static AssetId _output(String specificFile, BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      path.join('lib', 'src', 'full_responsive',
          'full_responsive_$specificFile.g.dart'),
    );
  }

  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {
    var yamlAssetId = await buildStep.findAssets(Glob('pubspec.yaml')).first;
    Map yaml;
    if (await buildStep.canRead(yamlAssetId)) {
      try {
        yaml = loadYaml(await buildStep.readAsString(yamlAssetId));
      } catch (e) {
        print(e);
        throw MalformedPubspecYaml();
      }
    } else {
      throw MalformedPubspecYaml();
    }
    final appWidgetOutput = _output('app', buildStep);
    final screenWidgetOutput = _output('screen', buildStep);
    var settings = Map.from(yaml['full_responsive']);
    var templatesProcessor = MustachexProcessor(initialVariables: settings);
    await Future.wait([
      buildStep.writeAsString(
          appWidgetOutput,
          formatDart(await templatesProcessor
              .process(fullResponsiveAppWidgetMustachexTemplate))),
      buildStep.writeAsString(
          screenWidgetOutput,
          formatDart(await templatesProcessor
              .process(fullResponsiveScreenWidgetMustachexTemplate))),
    ]);
  }

  String formatDart(String source) {
    return DartFormatter().format(source);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'lib/$lib$': const [
          r'lib/src/full_responsive/full_responsive_app.g.dart',
          r'lib/src/full_responsive/full_responsive_screen.g.dart',
        ]
      };
}
