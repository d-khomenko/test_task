// ignore_for_file: public_member_api_docs

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_task/ui/widgets/country_picker/country_code_picker.dart';

class AuthModel extends ChangeNotifier {
  final countryPicker = const CountryCodePicker();
  final TextEditingController controller = TextEditingController();
  CountryCode code = codes.map(CountryCode.fromMap).toList().first;
  bool _isButtonActive = false;

  final _phoneNumberStringDefaultLength = 14;

  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool get isButtonActive => _isButtonActive;

  void onEnteringPhoneNumber(String number) {
    _isButtonActive = number.length == _phoneNumberStringDefaultLength;
    notifyListeners();
  }

  Future<void> onCountryCodePickerTap(BuildContext context) async {
    code = await countryPicker.showPicker(context: context) ?? code;
    notifyListeners();
  }
}
