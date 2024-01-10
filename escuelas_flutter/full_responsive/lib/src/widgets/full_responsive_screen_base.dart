import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_responsive/src/exceptions/missing_full_responsive_app.dart';
import 'package:full_responsive/src/full_responsive.dart';
import 'package:full_responsive/src/widgets/full_responsive_app_base.dart';
import 'package:full_responsive/src/widgets/full_responsive_resolution.dart';

abstract class FullResponsiveScreenBase<T extends FullResponsiveAppBase>
    extends StatelessWidget {
  const FullResponsiveScreenBase({
    super.key,
    this.resolutionsOverrides,
    this.orientationsOverrides,
  });

  /// Normally full_responsive package would get the supported resolutions from the [FullResponsiveApp] generated
  /// widget, made from the resolutions defined globally for your app in the pubspec.yaml.
  /// Maybe some time you have a different design made for a specific screen, if so, override them here.
  final Map<FullResponsiveResolution, Widget>? resolutionsOverrides;

  /// Normally full_responsive package would deduce the supported device orientations from the [FullResponsiveApp]
  /// generated widget, made from the resolutions defined globally for your app in the pubspec.yaml.
  /// If you want this screen to be locked to a specific orientation different from that logic, use this property.
  final List<DeviceOrientation>? orientationsOverrides;

  @override
  Widget build(BuildContext context) {
    FullResponsiveAppBase fullResponsiveApp;
    List<FullResponsiveResolution> resolutions;
    List<FullResponsiveResolution> portraitResolutions;
    List<FullResponsiveResolution> landscapeResolutions;
    try {
      try {
        fullResponsiveApp = context.dependOnInheritedWidgetOfExactType<T>()!;
      } catch (e) {
        throw MissingFullResponsiveApp();
      }

      resolutions = resolutionsOverrides?.keys.toList() ??
          [...fullResponsiveApp.resolutions];
      if (resolutions.isEmpty) {
        return ErrorWidget.withDetails(
            message: 'Missing FullResponsiveResolution',
            error: FlutterError(
                'FullResponsive package requires you define at least one resolution for your app\n'
                ' make sure you defined it on your pubspec.yaml and rebuild with build_runner'));
      }
      portraitResolutions = [
        ...resolutions.where((resolution) => !resolution.isLandscape)
      ];
      landscapeResolutions = [
        ...resolutions.where((resolution) => resolution.isLandscape)
      ];
      //? Comentado x orden de Nico ya que esta deprecado(generaba error con algunos dispositivos)
      //? y probablemente no se use en la version mejorada.
      // var preferredOrientations = orientationsOverrides ??
      //     _orientationsDeduction(portraitResolutions, landscapeResolutions);
      // SystemChrome.setPreferredOrientations(preferredOrientations);
    } on MissingFullResponsiveApp {
      return ErrorWidget.withDetails(
          message: 'Missing FullResponsiveApp',
          error: FlutterError(
              'FullResponsiveScreen must be used with a FullResponsiveApp widget\n'
              ' defined upper in the widget tree. Did you forget to add one?'));
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Given that the breakpoints are being taken absolutely for screen sizes,
      // force the layout to be computed with full screen's size rather than the parent widget
      constraints = BoxConstraints.tight(MediaQuery.of(context).size);
      // avoid using a redundant [OrientationBuilder] with this copied code from it
      final Orientation orientation =
          constraints.maxWidth > constraints.maxHeight
              ? Orientation.landscape
              : Orientation.portrait;
      var filteredResolutions = (orientation == Orientation.portrait)
          ? portraitResolutions
          : landscapeResolutions;
      if (filteredResolutions.isEmpty) {
        var errorDetails = "There's no FullResponsiveResolution suitable for"
            'Orientation.${orientation.name} available.\n';
        errorDetails += (orientationsOverrides != null ||
                resolutionsOverrides != null)
            ? ' This normally happens when you override resolutions/orientations wrongly.'
            : ' Consider overriding the resolutions for this screen through "resolutionsOverrides" property.';
        return ErrorWidget.withDetails(
            message: 'Missing FullResponsiveResolution',
            error: FlutterError(errorDetails));
      }
      Widget? ret;
      FullResponsiveResolution chosenResolution;
      do {
        chosenResolution = resolutionChoosingLogic(
            orientation, constraints, filteredResolutions);
        ret = _resolutionToWidgetMapperWithOverrides(chosenResolution);
        filteredResolutions = [
          ...filteredResolutions.where((res) => res != chosenResolution)
        ];
      } while (ret == null && filteredResolutions.isNotEmpty);
      FullResponsive().reset(orientation, constraints.maxHeight,
          constraints.maxWidth, chosenResolution);
      Future(() {
        // mark the widget to be rendered by the FullResponsiveScreen to be rebuilt
        // for recomputing the measurements
        void redrawingVisitor(element) {
          element.markNeedsBuild();
          element.visitChildElements(redrawingVisitor);
        }

        context.visitChildElements(redrawingVisitor);
      });
      return ret ??
          ErrorWidget(
            'The resolution "${chosenResolution.name}" is not supported by this screen. '
            'Make sure you handled the overrides properly.',
          );
    });
  }

  Widget? _resolutionToWidgetMapperWithOverrides(
      FullResponsiveResolution chosenResolution) {
    if (resolutionsOverrides?.containsKey(chosenResolution) ?? false) {
      return resolutionsOverrides![chosenResolution];
    }
    return resolutionToWidgetMapper(chosenResolution);
  }

  /// This method should be generated by the tool
  Widget? resolutionToWidgetMapper(FullResponsiveResolution resolution);

  FullResponsiveResolution resolutionChoosingLogic(Orientation orientation,
      BoxConstraints constraints, List<FullResponsiveResolution> resolutions) {
    FullResponsiveResolution? ret;
    if (orientation == Orientation.portrait) {
      resolutions.sort(((a, b) => a.height.compareTo(b.height)));
      for (var r in resolutions) {
        ret ??= r;
        if (r.breakpoint <= constraints.maxWidth) {
          ret = r;
        }
      }
    } else {
      resolutions.sort(((a, b) => a.width.compareTo(b.width)));
      for (var r in resolutions) {
        ret ??= r;
        if (r.breakpoint <= constraints.maxHeight) {
          ret = r;
        }
      }
    }
    return ret!;
  }

  /// processes the different resolutions defined and returns Flutter framework's device orientations arguments
  List<DeviceOrientation> _orientationsDeduction(
    List<FullResponsiveResolution> portraitResolutions,
    List<FullResponsiveResolution> landscapeResolutions,
  ) {
    if (portraitResolutions.isEmpty && landscapeResolutions.isEmpty) {
      throw UnsupportedError(
          'This error should be impossible. Please report it.');
    } else if (portraitResolutions.isEmpty) {
      return [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
    } else if (landscapeResolutions.isEmpty) {
      return [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ];
    } else {
      return [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
    }
  }
}
