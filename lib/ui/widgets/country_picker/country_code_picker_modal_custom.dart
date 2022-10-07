import 'dart:developer';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_task/resources/app_assets.dart';
import 'package:test_task/ui/theme/app_colors.dart';

/// {@template country_code_picker_modal}
/// Widget that can be used on showing a modal as bottom sheet that
/// contains all of the [CountryCode]s.
///
/// After pressing the [CountryCode]'s [ListTile], the widget pops
/// and returns the selected [CountryCode] which can be manipulated.
/// {@endtemplate}
class CountryCodePickerModalCustom extends StatefulWidget {
  /// {@macro favorites}
  final List<String> favorites;

  /// {@macro filtered_countries}
  final List<String> filteredCountries;

  /// {@macro favorite_icon}
  final Icon favoritesIcon;

  /// {@macro show_search_bar}
  final bool showSearchBar;

  /// If not null, automatically scrolls the list view to this country.
  final String? focusedCountry;

  /// {@macro country_code_picker_modal}
  const CountryCodePickerModalCustom({
    Key? key,
    this.favorites = const [],
    this.filteredCountries = const [],
    required this.favoritesIcon,
    required this.showSearchBar,
    this.focusedCountry,
  }) : super(key: key);

  @override
  State<CountryCodePickerModalCustom> createState() =>
      _CountryCodePickerModalState();
}

class _CountryCodePickerModalState extends State<CountryCodePickerModalCustom> {
  List<CountryCode>? baseList;
  final availableCountryCodes = <CountryCode>[];

  TextEditingController? textController;
  ItemScrollController? itemScrollController;

  @override
  void initState() {
    _initCountries();
    super.initState();
  }

  Future<void> _initCountries() async {
    final allCountryCodes = codes.map(CountryCode.fromMap).toList();
    textController = TextEditingController();
    itemScrollController = ItemScrollController();

    final favoriteList = <CountryCode>[
      if (widget.favorites.isNotEmpty)
        ...allCountryCodes.where((c) => widget.favorites.contains(c.code))
    ];
    final filteredList = [
      ...widget.filteredCountries.isNotEmpty
          ? allCountryCodes.where(
              (c) => widget.filteredCountries.contains(c.code),
            )
          : allCountryCodes,
    ]..removeWhere((c) => widget.favorites.contains(c.code));

    baseList = [...favoriteList, ...filteredList];
    availableCountryCodes.addAll(baseList ?? []);

    // Temporary fix. Bug when initializing scroll controller.
    // https://github.com/google/flutter.widgets/issues/62
    await Future<void>.delayed(Duration.zero);

    if (!(itemScrollController?.isAttached ?? false)) return;

    if (widget.focusedCountry != null) {
      final index = availableCountryCodes.indexWhere(
        (c) => c.code == widget.focusedCountry,
      );

      await itemScrollController?.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 600),
      );
    }
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const flagHeight = 20.0;
    const flagWidth = 38.0;
    const flagBorderRadius = 8.0;
    const boderRadius = 16.0;
    const rightInsetCancelButton = 20.0;
    const topInsetCancelButton = 20.0;
    const cancelButtonHeight = 20.0;
    const cancelButtonWidth = 20.0;

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ModalTitle(),
            if (widget.showSearchBar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: boderRadius),
                child: TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.textColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(boderRadius),
                    ),
                    filled: true,
                    fillColor: AppColors.inactiveColor,
                    hintText: "Search",
                    hintStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    prefixIcon: SvgPicture.asset(
                      AppAssets.searchSvg,
                      fit: BoxFit.scaleDown,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14.0,
                    ),
                  ),
                  onChanged: (query) {
                    availableCountryCodes
                      ..clear()
                      ..addAll(
                        List<CountryCode>.from(
                          baseList?.where(
                                (c) =>
                                    c.code
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    c.dialCode
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    c.name
                                        .toLowerCase()
                                        .contains(query.toLowerCase()),
                              ) ??
                              <CountryCode>[],
                        ),
                      );
                    setState(() {
                      log("filtered codes...");
                    });
                  },
                ),
              ),
            Expanded(
              child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemCount: availableCountryCodes.length,
                itemBuilder: (context, index) {
                  final code = availableCountryCodes[index];

                  return ListTile(
                    onTap: () => Navigator.pop(context, code),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(flagBorderRadius),
                      child: SizedBox(
                        height: flagHeight,
                        width: flagWidth,
                        child: code.flagImage,
                      ),
                    ),
                    title: _ListTrailing(
                      code: code,
                      favorites: widget.favorites,
                      icon: widget.favoritesIcon,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          right: rightInsetCancelButton,
          top: topInsetCancelButton,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: cancelButtonHeight,
              width: cancelButtonWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                color: AppColors.inactiveColor,
              ),
              child: SvgPicture.asset(
                AppAssets.crossSmallSvg,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ListTrailing extends StatelessWidget {
  final CountryCode code;
  final List<String> favorites;
  final Icon icon;
  const _ListTrailing({
    Key? key,
    required this.code,
    required this.favorites,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const countryCodeSize = 60.0;
    const flagWithPaddings = 100.0;

    if (favorites.isEmpty) {
      final iconWidth = MediaQuery.of(context).size.width;

      return SizedBox(
        width: iconWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: countryCodeSize,
              child: Text(
                code.dialCode,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: iconWidth - countryCodeSize - flagWithPaddings,
              child: Text(
                overflow: TextOverflow.clip,
                code.name,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final index = favorites.indexWhere((f) => f == code.code);
    final iconWidth = MediaQuery.of(context).size.width * 0.2;

    return SizedBox(
      width: iconWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(code.dialCode),
          if (index != -1) icon,
        ],
      ),
    );
  }
}

class _ModalTitle extends StatelessWidget {
  const _ModalTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Country code',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 32,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
