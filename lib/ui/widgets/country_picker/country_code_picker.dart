import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_task/ui/theme/app_colors.dart';
import 'package:test_task/ui/widgets/country_picker/country_code_picker_modal_custom.dart';

/// Default favorites icon.
const _kFavoritesIcon = Icon(Icons.favorite, color: Colors.red);

/// Default modal and TextField default borderRadius.
const kBorderRadius = Radius.circular(20);

/// Default modal background color.
const _kBackgroundColor = AppColors.primarySwatch;

/// Default modal barrier color.
const _kBarrierColor = Color(0x50000000);

/// Default min height
const _pickerMinHeight = 150.0;

/// Default max height
const _pickerMaxHeight = 620.0;

/// {@template fl_country_code_picker}
/// A Flutter package for showing a modal that contains country dial code.
///
/// The user can also search for the available codes and
/// select right from the modal.
/// {@endtemplate}
class CountryCodePicker {
  /// {@template favorites}
  /// Favorite [CountryCode]s that can be shown at the top of the list.
  ///
  /// Should supply the 2 character ISO code of the country.
  ///
  /// Based from: https://countrycode.org/
  /// {@endtemplate}
  final List<String> favorites;

  /// {@template filtered_countries}
  /// Filters all of the [CountryCode]s available and only show the codes that
  /// are existing in this list.
  /// {@endtemplate}
  final List<String> filteredCountries;

  /// {@template favorite_icon}
  /// Custom icon of favorite countries.
  ///
  /// <i class="material-icons md-36">favorite</i> &#x2014;  Defaults to `Icons.favorite`
  /// {@endtemplate}
  final Icon favoritesIcon;

  /// {@template show_search_bar}
  /// An optional argument for showing search bar.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool showSearchBar;

  /// Convinience getter for all of the available country codes.
  List<CountryCode> get countryCodes => List<CountryCode>.from(
        codes.map<CountryCode>(CountryCode.fromMap),
      );

  /// {@macro fl_country_code_picker}
  const CountryCodePicker({
    this.favorites = const [],
    this.filteredCountries = const [],
    this.favoritesIcon = _kFavoritesIcon,
    this.showSearchBar = true,
  });

  /// Adds all favorites to the list.
  void addFavorites(List<String> countries) => favorites.addAll(countries);

  /// Adds all of filtered countries to the list.
  // void addFilteredCountries(List<String> countries) =>
  //     filteredCountries.addAll(filteredCountries);

  /// Shows the [CountryCodePickerModal] modal.
  ///
  /// Props:
  /// * context - A handle to the location of a widget in the widget tree.
  /// * isFullScreen - Shows the modal in full screen mode.
  /// * pickerMinHeight / pickerMaxHeight - Picker modal constraints.
  /// * scrollToDeviceLocale - Automatically scroll to device's locale.
  /// * initialSelectedLocale - Automatically scroll to user-defined locale.
  ///
  /// If `scrollToDeviceLocale` was set to `true`, it will override the
  /// value from `initialSelectedLocale` prop.
  ///
  /// Returns the selected [CountryCode] by the user.
  Future<CountryCode?> showPicker({
    required BuildContext context,
    bool fullScreen = false,
    double pickerMinHeight = _pickerMinHeight,
    double pickerMaxHeight = _pickerMaxHeight,
    bool scrollToDeviceLocale = false,
    String? initialSelectedLocale,
  }) async {
    // Computations for modal height.
    final fullScreenHeight = MediaQuery.of(context).size.height;
    final allowance = MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    // Gets the country code of the device.
    final locale = WidgetsBinding.instance.window.locale.countryCode;

    final country = showModalBottomSheet<CountryCode?>(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: kBorderRadius,
          topRight: kBorderRadius,
        ),
      ),
      backgroundColor: _kBackgroundColor,
      barrierColor: _kBarrierColor,
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
        maxHeight: fullScreen ? fullScreenHeight - allowance : pickerMaxHeight,
        minHeight: pickerMinHeight,
      ),
      builder: (_) => CountryCodePickerModalCustom(
        favorites: favorites,
        filteredCountries: filteredCountries,
        favoritesIcon: favoritesIcon,
        showSearchBar: showSearchBar,
        focusedCountry: scrollToDeviceLocale ? locale : initialSelectedLocale,
      ),
    );

    return country;
  }
}
