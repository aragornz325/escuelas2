// ignore_for_file: strict_raw_type, avoid_positional_boolean_parameters

import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template PRDropdown}
/// Dropdown widget used in the app.
/// {@endtemplate}
class EscuelasDropdown<T> extends StatefulWidget {
  /// {@macro PRDropdown}
  const EscuelasDropdown({
    required this.isValid,
    required this.items,
    required this.hintText,
    required this.valueText,
    required this.onChanged,
    this.value,
    this.padding,
    this.hintStyle,
    this.maxItemsCount = 9999,
    this.enabled = true,
    this.additionalOption,
    this.icon,
    this.preffixIcon,
    this.height,
    this.boxShadow,
    this.hasSearchField = false,
    this.physics,
    this.showIcon = true,
    this.valueColor,
    this.itemHeight,
    this.onExpand,
    this.itemPadding,
    this.hideHeight,
    this.notExpandedHeight,
    this.width,
    this.margin,
    super.key,
  });

  /// Height of the dropdown box. If null, it will be 64 pixels.
  final double? hideHeight;

  /// Whether the dropdown is valid or not.
  final bool isValid;

  /// The current value of the dropdown.
  final T? value;

  /// The items to show in the dropdown.
  final List<PRDropdownOption<T>> items;

  /// The hint text to show in the dropdown.
  final String hintText;

  /// The style of the hint text.
  final TextStyle? hintStyle;

  /// The text to show when the dropdown has a value.
  final String valueText;

  /// El maximo de lineas que puede tener el texto del dropdown.
  final int maxItemsCount;

  /// The method to call when the dropdown changes.
  final void Function(T value) onChanged;

  /// The icon in the left side of the dropdown.
  final Widget? icon;

  /// The icon in the right side of the dropdown.
  final Widget? preffixIcon;

  /// Add an option extra to the dropdown.
  final PRDropdownOption<T>? additionalOption;

  /// The height of the dropdown.
  final double? height;

  /// The height of the dropdown.
  final double? itemHeight;

  /// BoxShadow of the dropdown.
  final List<BoxShadow>? boxShadow;

  /// Set if the dropdown is valid or not.
  final bool enabled;

  /// Wether or not has searchField.
  final bool hasSearchField;

  /// Physics of the dropdown.
  final ScrollPhysics? physics;

  /// Show the icon of the dropdown.
  final bool showIcon;

  /// The color of the value text.
  final Color? valueColor;

  /// The method to call when the dropdown is expanded.
  final void Function(bool value)? onExpand;

  /// The padding of the item dropdown.
  final EdgeInsets? itemPadding;

  /// The height of the dropdown when it is not expanded.
  final double? notExpandedHeight;

  /// The padding of the dropdown.
  final EdgeInsets? padding;

  /// The margin of the dropdown.
  final EdgeInsets? margin;

  /// The width of the dropdown.
  final double? width;

  @override
  State<EscuelasDropdown<T>> createState() => _EscuelasDropdownState<T>();
}

class _EscuelasDropdownState<T> extends State<EscuelasDropdown<T>> {
  bool _isExpanded = false;

  final _controller = TextEditingController();

  final _focusNode = FocusNode();

  List<PRDropdownOption<T>> items = [];

  @override
  void initState() {
    super.initState();

    if (!widget.hasSearchField) return;

    _controller.addListener(() {
      setState(() {
        filterSearchResults(_controller.text);
      });
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        items = widget.items;
      } else {
        items = widget.items.where(
          (element) {
            return element.title.toUpperCase().contains(
                  query.toUpperCase(),
                );
          },
        ).toList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    items = _controller.text.isEmpty ? widget.items : items;

    final listLength = min(
      (widget.itemHeight ?? 38.5.ph) * items.length +
          (widget.additionalOption != null ? 128.ph : 64.ph) +
          (widget.hasSearchField ? 84.ph : 0),
      (widget.itemHeight ?? 38.5.ph) *
              (widget.maxItemsCount > 6 ? 6 : widget.maxItemsCount) +
          (widget.additionalOption != null ? 128.ph : 64.ph) +
          (widget.hasSearchField ? 84.ph : 0),
    );

    final heigth = widget.notExpandedHeight ?? (50.ph);

    return Container(
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                height: _isExpanded ? widget.height ?? listLength : heigth,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.sw),
                  boxShadow: widget.boxShadow ??
                      [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 1.ph),
                          blurRadius: 4.sw,
                        ),
                      ],
                ),
                child: Scrollbar(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          primary: true,
                          physics: widget.physics,
                          children: [
                            SizedBox(height: widget.hideHeight ?? heigth),
                            if (widget.hasSearchField)
                              Padding(
                                padding: EdgeInsets.all(11.pw)
                                    .copyWith(bottom: 5.ph),
                                child: EscuelasTextfield(
                                  hintText: 'Search ..',
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  prefixIcon: Icons.search,
                                  esPassword: false,
                                  onEditingComplete: _focusNode.unfocus,
                                  onFieldSubmitted: (_) => _focusNode.unfocus(),
                                ),
                              ),
                            ...items.map((option) {
                              return _PRDropdownOptionWidget<T>(
                                padding: widget.itemPadding,
                                color: option.color,
                                enabled: option.enabled,
                                title: option.title,
                                value: option.value,
                                textStyle: option.textStyle,
                                checkBoxCallback: option.checkBoxCallback,
                                checkBoxValue: option.checkBoxValue,
                                preffixIcon: option.preffixIcon,
                                itemHeight: option.itemHeight,
                                traillingIcon: option.traillingIcon,
                                callback: () {
                                  widget.onChanged.call(option.value);
                                  option.callback?.call();
                                  if (option.checkBoxValue == null) {
                                    setState(() => _isExpanded = false);
                                  }
                                },
                              );
                            }),
                            SizedBox(height: 10.ph),
                          ],
                        ),
                      ),
                      if (widget.additionalOption != null) ...[
                        Divider(color: colores.onSecondary),
                        _PRDropdownOptionWidget(
                          title: widget.additionalOption?.title ?? '',
                          value: widget.additionalOption?.value,
                          traillingIcon: widget.additionalOption?.traillingIcon,
                          checkBoxCallback:
                              widget.additionalOption?.checkBoxCallback,
                          checkBoxValue: widget.additionalOption?.checkBoxValue,
                          icon: widget.additionalOption?.icon,
                          itemHeight: widget.additionalOption?.itemHeight,
                          preffixIcon: widget.additionalOption?.preffixIcon,
                          callback: () {
                            widget.additionalOption?.callback?.call();
                            setState(() => _isExpanded = false);
                          },
                        ),
                        SizedBox(height: max(6.ph, 6.sh)),
                      ],
                    ],
                  ),
                ),
              ),
              if (!widget.isValid)
                Padding(
                  padding: EdgeInsets.only(top: 6.ph, left: 10.pw),
                  child: Text(
                    'debes completar este campo',
                    style: TextStyle(
                      color: colores.error,
                      fontSize: 12.pf,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
          InkWell(
            onTap: () {
              if (widget.enabled == false) return;
              setState(() => _isExpanded = !_isExpanded);
              widget.onExpand?.call(_isExpanded);
            },
            child: Column(
              children: [
                Container(
                  height: heigth,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colores.background,
                    borderRadius: BorderRadius.circular(8.sw),
                    border: widget.isValid
                        ? null
                        : Border.all(
                            color: colores.error,
                            width: 1.pw,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0, 2.ph),
                        blurRadius: 4.sw,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: widget.icon != null ? 5.pw : 1.pw),
                      if (widget.icon != null) widget.icon!,
                      SizedBox(width: widget.icon != null ? 5.pw : 1.pw),
                      Expanded(
                        flex: 20,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.pw),
                          child: Text(
                            widget.value != null
                                ? widget.valueText
                                : widget.hintText,
                            style: widget.hintStyle ??
                                TextStyle(
                                  color: widget.value != null
                                      ? widget.valueColor ?? colores.primary
                                      : widget.enabled
                                          ? colores.onBackground
                                          : colores.secondary.withOpacity(0.2),
                                  fontSize: 16.pf,
                                  fontWeight: widget.value != null
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (widget.showIcon)
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 150),
                          turns: _isExpanded ? 0.5 : 0,
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 24.pw,
                            color: widget.enabled
                                ? colores.secondary
                                : const Color(0xff4F4F4F).withOpacity(0.2),
                          ),
                        ),
                      SizedBox(width: 13.pw),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template PRDropdownOption}
/// This class is used to display the options of the dropdown.
/// {@endtemplate}
class PRDropdownOption<T> {
  /// {@macro PRDropdownOption}
  const PRDropdownOption({
    required this.title,
    required this.value,
    this.enabled = true,
    this.callback,
    this.checkBoxValue,
    this.checkBoxCallback,
    this.preffixIcon,
    this.icon,
    this.itemHeight,
    this.color = Colors.transparent,
    this.traillingIcon,
    this.textStyle,
  });

  /// The color of the option.
  final Color color;

  /// If the option is enabled.
  final bool enabled;

  /// The title of the option.
  final String title;

  /// The value of the option.
  final T value;

  /// The callback to execute when the option is tapped.
  final void Function()? callback;

  /// Value of the checkbox.
  final bool? checkBoxValue;

  /// The method to call when the option is tapped.
  final void Function(bool?)? checkBoxCallback;

  /// Icon in the option.
  final Widget? icon;

  /// preffixIcon in the option.
  final Widget? preffixIcon;

  /// The heigth of the option.
  final double? itemHeight;

  /// The icon on the rigth side of the option.
  final IconData? traillingIcon;

  /// Text style of the option.
  final TextStyle? textStyle;
}

class _PRDropdownOptionWidget<T> extends StatefulWidget {
  const _PRDropdownOptionWidget({
    required this.title,
    required this.value,
    required this.traillingIcon,
    this.color = Colors.green,
    this.callback,
    this.checkBoxCallback,
    this.checkBoxValue,
    this.icon,
    this.preffixIcon,
    this.itemHeight,
    this.enabled = true,
    this.padding,
    this.textStyle,
  });

  /// The text style of the option.
  final TextStyle? textStyle;

  /// The padding of the option.
  final EdgeInsets? padding;

  /// The color of the option.
  final Color color;

  /// If the option is enabled.
  final bool enabled;

  /// The title of the option.
  final String title;

  /// The value of the option.
  final T value;

  /// The callback to execute when the option is tapped.
  final void Function()? callback;

  /// Value of the checkbox.
  final bool? checkBoxValue;

  /// Icon in the option.
  final Widget? icon;

  /// PreffixIcon in the option.
  final Widget? preffixIcon;

  /// The heigth of the option.
  final double? itemHeight;

  /// The method to call when the option is tapped.
  final void Function(bool? value)? checkBoxCallback;

  /// The icon on the rigth side of the option.
  final IconData? traillingIcon;

  @override
  State<_PRDropdownOptionWidget<T>> createState() =>
      _PRDropdownOptionWidgetState<T>();
}

class _PRDropdownOptionWidgetState<T>
    extends State<_PRDropdownOptionWidget<T>> {
  late bool? _estaSeleccionado;

  @override
  void initState() {
    _estaSeleccionado = widget.checkBoxValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final preffixIcon = widget.preffixIcon;
    final icon = widget.icon;

    return Container(
      margin: EdgeInsets.only(top: 6.ph),
      height: widget.itemHeight ?? 30.ph,
      color: widget.checkBoxValue != null
          ? (_estaSeleccionado ?? false ? colores.primaryOpacidadVeinte : null)
          : widget.color,
      child: MaterialButton(
        onPressed: widget.enabled
            ? () {
                setState(() {
                  widget.callback?.call();

                  if (widget.checkBoxCallback != null) {
                    _estaSeleccionado = !(_estaSeleccionado ?? false);
                  }
                });
              }
            : () {},
        highlightColor: colores.primaryOpacidadVeinte,
        padding: widget.preffixIcon != null ? null : null,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (preffixIcon != null) preffixIcon,
              Expanded(
                flex: 20,
                child: Row(
                  children: [
                    SizedBox(width: 5.pw),
                    Text(
                      widget.title,
                      style: widget.textStyle ??
                          TextStyle(
                            fontSize: 16.pf,
                            color: colores.onBackground,
                            fontWeight: FontWeight.w400,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (widget.traillingIcon != null)
                Icon(
                  widget.traillingIcon,
                  color: colores.primary,
                  size: 20.pw,
                ),
              if (widget.checkBoxValue != null)
                Checkbox(
                  value: _estaSeleccionado,
                  onChanged: (value) {
                    setState(() {
                      _estaSeleccionado = value;
                      widget.checkBoxCallback?.call(value);
                    });
                  },
                  activeColor: colores.primary,
                  checkColor: colores.background,
                ),
              if (icon != null) icon,
            ],
          ),
        ),
      ),
    );
  }
}
