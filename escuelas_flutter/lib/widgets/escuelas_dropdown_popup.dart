import 'dart:async';
import 'dart:math';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class EscuelasDropdownPopup extends StatefulWidget {
  const EscuelasDropdownPopup({
    required this.list,
    required this.onChanged,
    this.padding,
    this.numberOfOptionsShown,
    this.dropdownButtonIcon,
    this.width,
    this.heightTile = 50,
    this.initiallySelected = const [],
    this.hintText = 'Select an option',
    this.textStyle = const TextStyle(fontSize: 15),
    this.selectedOptionColor = Colors.grey,
    this.unSelectedOptionColor = Colors.white,
    this.iconsColor = Colors.black,
    this.isEnabled = true,
    this.includeSelectAll = false,
    this.alwaysOneSelected = false,
    this.includeSearch = false,
    this.multiSelect = false,
    super.key,
  });

  /// List of options to select from
  final List<PopupOption> list;

  /// returns the list of selected options
  final ValueChanged<List<PopupOption>> onChanged;

  /// Padding of the dropdown button.
  final EdgeInsets? padding;

  /// The number of options to show in the dropdown menu
  final int? numberOfOptionsShown;

  /// Width of the input widget. If this
  /// is null the widget will try to take
  /// full width of the parent.
  ///
  /// When rendering in a Row it needs to have
  /// a strict parent or a fixed width as it grows
  /// horizontally
  final double? width;

  /// The icon shown on the dropdown button
  final Icon? dropdownButtonIcon;

  /// Height of the options.
  final double heightTile;

  /// Initially selected list
  final List<PopupOption> initiallySelected;

  /// Text to show when selected list is empty
  final String hintText;

  /// TextStyle for the text on the dropdown button.
  final TextStyle textStyle;

  /// Color of the selected options
  final Color selectedOptionColor;

  /// Color of the unselected option
  final Color unSelectedOptionColor;

  /// Color of the options icons
  final Color iconsColor;

  /// Indicates if the widget is enabled
  final bool isEnabled;

  /// Includes a select all button when `true`
  final bool includeSelectAll;

  /// Always keep an option selected
  final bool alwaysOneSelected;

  /// Includes a search option when `true`
  final bool includeSearch;

  /// Allows multiple options to be selected
  final bool multiSelect;

  @override
  State<EscuelasDropdownPopup> createState() => _EscuelasDropdownPopupState();
}

class _EscuelasDropdownPopupState extends State<EscuelasDropdownPopup> {
  /// Height of aditional options like select all or search.
  double aditionalOptionHeight = 40;

  /// Initialize selected list on the parameter initiallySelected
  late List<PopupOption> selectedList = [...widget.initiallySelected];

  /// Filtered options to show when search bar is shown.
  List<PopupOption> filteredOptions = [];

  /// MenuController to open and close the menu
  MenuController menuController = MenuController();

  TextEditingController filterController = TextEditingController();

  /// Open/Close the menu depending on the multiselect property and returns the new list of selected options
  void handleOnChange({
    required bool newValue,
    required PopupOption option,
  }) {
    if (widget.multiSelect == false) {
      setState(() {
        menuController.close();
      });
    }
    if (newValue) {
      setState(() {
        selectedList.add(option);
      });
    } else {
      final optionIndex = selectedList.indexWhere(
        (obj) => obj.id == option.id,
      );
      if (optionIndex == -1) {
        return;
      } else {
        setState(() {
          selectedList.removeAt(optionIndex);
        });
      }
    }

    widget.onChanged(selectedList);
  }

  /// Get the width of the parent or the given width
  double getWidth(BoxConstraints boxConstraints) {
    if (widget.width != null &&
        widget.width != double.infinity &&
        widget.width != double.maxFinite) {
      return widget.width!;
    }
    if (boxConstraints.maxWidth == double.infinity ||
        boxConstraints.maxWidth == double.maxFinite) {
      debugPrint('Invalid width given, MultiSelectDropdowns width will '
          'fallback to 250.');
      return 250;
    }
    return boxConstraints.maxWidth;
  }

  /// Builds the text on the dropdown button from the selected list of options
  /// or the hint
  String buildText() {
    if (selectedList.isEmpty) {
      return widget.hintText;
    }

    final stringBuffer = StringBuffer();
    final optionsToShow = selectedList.length;

    for (var i = 0; i < optionsToShow; i++) {
      stringBuffer.write(selectedList[i].name);

      if (i < optionsToShow - 1) {
        stringBuffer.write(', ');
      }
    }

    return stringBuffer.toString();
  }

  /// Get the height of the modal based on the number of options
  double getModalHeight() {
    var height =
        (widget.numberOfOptionsShown ?? min(filteredOptions.length, 4)) *
            widget.heightTile.sh;

    if (widget.includeSelectAll) {
      height += aditionalOptionHeight;
    }

    if (widget.includeSearch) {
      height += aditionalOptionHeight;
    }

    return height;
  }

  /// Indicate if the option is selected
  bool isSelected(int optionId) {
    for (final obj in selectedList) {
      if (obj.id == optionId) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    filteredOptions = [...widget.list];
    super.initState();
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return LayoutBuilder(
      builder: (ctx, boxConstraints) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: widget.heightTile.sh,
            width: getWidth(boxConstraints).sw,
          ),
          child: MenuAnchor(
            crossAxisUnconstrained: false,
            style: MenuStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) {
                return Size(getWidth(boxConstraints), getModalHeight());
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => colores.tertiary,
              ),
              elevation: MaterialStateProperty.resolveWith((states) {
                return 0.0;
              }),
            ),
            builder: (context, controller, _) {
              menuController = controller;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (widget.isEnabled) {
                      if (menuController.isOpen) {
                        controller.close();
                      } else {
                        setState(() {
                          filteredOptions = widget.list;
                        });
                        controller.open();
                      }
                    }
                  },
                  child: Container(
                    padding: widget.padding ??
                        EdgeInsets.symmetric(horizontal: 12.sw),
                    decoration: BoxDecoration(
                      borderRadius: controller.isOpen
                          ? BorderRadius.only(
                              topRight: Radius.circular(10.sw),
                              topLeft: Radius.circular(10.sw),
                            )
                          : BorderRadius.all(Radius.circular(10.sw)),
                      color: colores.tertiary,
                    ),
                    width: getWidth(boxConstraints).sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (widget.dropdownButtonIcon != null)
                              Row(
                                children: [
                                  widget.dropdownButtonIcon!,
                                  SizedBox(
                                    width: 5.sh,
                                  ),
                                ],
                              ),
                            SizedBox(
                              width: getWidth(boxConstraints) - 104.sw,
                              child: Text(
                                buildText(),
                                style: widget.textStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          controller.isOpen
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down_sharp,
                          color: colores.secondary,
                          size: 24.sw,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            menuChildren: [
              if (widget.includeSearch)
                _SearchOption(
                  filterController: filterController,
                  searchOptionHeight: aditionalOptionHeight,
                  onChanged: (searchText) {
                    if (searchText.isEmpty) {
                      setState(() {
                        filteredOptions = widget.list;
                      });
                    } else {
                      searchText = searchText.toLowerCase();

                      final newList = widget.list.where((option) {
                        return option.name.toLowerCase().contains(searchText);
                      }).toList();

                      setState(() {
                        filteredOptions = newList;
                      });
                    }
                  },
                ),
              if (widget.includeSelectAll)
                _SelectAllButton(
                  onTap: () {
                    if (selectedList.length == widget.list.length) {
                      selectedList.clear();
                    } else {
                      selectedList.clear();
                      selectedList = [...widget.list];
                    }
                    widget.onChanged(selectedList);
                    setState(() {});
                  },
                  selectAllButtonHeight: aditionalOptionHeight,
                ),
              ...filteredOptions.map(
                (option) => _CustomTile(
                  option: option,
                  filterController: filterController,
                  heightTile: widget.heightTile,
                  selectedList: selectedList,
                  alwaysOneSelected: widget.alwaysOneSelected,
                  unSelectedOptionColor: widget.unSelectedOptionColor,
                  selectedOptionColor: widget.selectedOptionColor,
                  multiSelect: widget.multiSelect,
                  unSelectAll: selectedList.clear,
                  isSelected: isSelected(option.id),
                  onChanged: (value) =>
                      handleOnChange(newValue: value, option: option),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// The tile to display
class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.selectedOptionColor,
    required this.unSelectedOptionColor,
    required this.isSelected,
    required this.onChanged,
    required this.unSelectAll,
    required this.multiSelect,
    required this.option,
    required this.heightTile,
    required this.filterController,
    this.alwaysOneSelected = false,
    this.selectedList = const [],
  });

  /// Indicate if the option is selected
  final bool isSelected;

  /// Called when the user taps a tile
  final ValueChanged<bool> onChanged;

  /// Called when the user taps the select all button
  final VoidCallback unSelectAll;

  /// Allows multiple options to be selected
  final bool multiSelect;

  /// Color of the selected option
  final Color selectedOptionColor;

  /// Color of the unselected option
  final Color unSelectedOptionColor;

  /// Always keep an option selected
  final bool alwaysOneSelected;

  /// List of selected options
  final List<PopupOption> selectedList;

  /// Height of the tile
  final double heightTile;

  /// The option to display
  final PopupOption option;

  final TextEditingController filterController;

  /// Handles the onChange event when an option is selected or unselected
  void handleOnChange() {
    if (isSelected) {
      if (!(alwaysOneSelected && selectedList.length == 1)) {
        onChanged(false);
        if (!multiSelect) unSelectAll();
      }
    } else {
      if (!multiSelect) unSelectAll();
      onChanged(true);
    }
  }

  /// It divides a name obtained from the list to put the letters that match in
  /// a highlighted color and the other joins it to the red string to indicate
  ///  to the user that their search matches.
  List<String> highlightSearch(String searchedText, String text) {
    var startIndex = 0;

    final occurrences = <int>[];

    final list = <String>[];

    while (startIndex < text.length) {
      final index =
          text.toLowerCase().indexOf(searchedText.toLowerCase(), startIndex);
      if (index == -1) {
        break;
      }
      occurrences.add(index);
      startIndex = index + 1;
    }

    for (var i = 0; i < occurrences.length; i++) {
      final currentIndex = occurrences[i];
      final result = text.substring(
        i == 0 ? 0 : occurrences[i - 1] + searchedText.length,
        currentIndex,
      );
      final result2 =
          text.substring(currentIndex, currentIndex + searchedText.length);
      if (i == 0 && result.isEmpty) {
      } else {
        list.add(result);
      }
      list.add(result2);
    }

    if (occurrences.isNotEmpty &&
        occurrences.last + searchedText.length < text.length) {
      final result = text.substring(occurrences.last + searchedText.length);
      list.add(result);
    } else if (occurrences.isEmpty) {
      list.add(text);
    }

    return list;
  }

  /// Changes the first letter to be a capital one.
  String capitalizeFirstLetter(String name) {
    if (name.isEmpty) {
      return name;
    }
    final firstLetter = name.substring(0, 1).toUpperCase();
    final restOfName = name.substring(1);
    final result = firstLetter + restOfName;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: handleOnChange,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? selectedOptionColor : colores.tertiary,
          ),
          height: heightTile,
          child: Row(
            children: [
              SizedBox(width: 9.sw),
              if (option.imageUrl != null)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.sw),
                  width: 30.pw,
                  height: 30.sh,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colores.outline,
                  ),
                )
              else if (option.icon != null)
                Icon(
                  option.icon,
                  color: colores.primary,
                  size: 20.sw,
                ),
              SizedBox(width: 9.sw),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: highlightSearch(
                      filterController.text,
                      option.name,
                    )
                        .map(
                          (e) => TextSpan(
                            text: e,
                            style: TextStyle(
                              color: e == filterController.text ||
                                      e ==
                                          capitalizeFirstLetter(
                                            filterController.text,
                                          )
                                  ? colores.error
                                  : colores.onBackground,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// When its enabled the user can search on a textfield and filter the options
class _SearchOption extends StatefulWidget {
  const _SearchOption({
    required this.searchOptionHeight,
    required this.onChanged,
    required this.filterController,
  });
  final double searchOptionHeight;

  final void Function(String) onChanged;

  final TextEditingController filterController;

  @override
  State<_SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<_SearchOption> {
  Timer? debounce;

  void onSearchTextChanged(String searchText) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged(searchText);
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.filterController,
      onChanged: onSearchTextChanged,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: 'Filter...',
        constraints: BoxConstraints(
          minHeight: widget.searchOptionHeight.sh,
          maxHeight: widget.searchOptionHeight.sh,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.sw,
          vertical: 10.sw,
        ),
      ),
    );
  }
}

/// A button that the user can click to select all the options
class _SelectAllButton extends StatelessWidget {
  const _SelectAllButton({
    required this.onTap,
    required this.selectAllButtonHeight,
  });

  /// Called when the user clicks the button
  final VoidCallback onTap;

  /// Height of the button
  final double selectAllButtonHeight;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: selectAllButtonHeight,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 18.sw),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          child: Text(
            'Select all',
            style: TextStyle(color: colores.onBackground),
          ),
        ),
      ),
    );
  }
}

/// Model of an option of the popup dropdown
class PopupOption {
  const PopupOption({
    required this.id,
    required this.name,
    this.icon,
    this.imageUrl,
  });

  /// Option id
  final int id;

  /// Option name
  final String name;

  /// Option icon
  final IconData? icon;

  /// Option image
  final String? imageUrl;
}
