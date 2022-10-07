// ignore_for_file: public_member_api_docs
import 'dart:developer';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_task/resources/app_assets.dart';
import 'package:test_task/ui/theme/app_colors.dart';
import 'package:test_task/ui/widgets/country_picker/country_code_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController controller = TextEditingController();
  bool isButtonActive = false;

  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final int correctLenghtForPhoneNumber = 14;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        isButtonActive = controller.text.length == correctLenghtForPhoneNumber;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: AppColors.primarySwatch,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 48, left: 20),
                  child: _GetStartedWidget(),
                ),
                const SizedBox(
                  height: 160,
                ),
                _PhoneNumbersWidgets(
                  myController: controller,
                  maskFormatter: maskFormatter,
                ),
                Expanded(
                  child: _SubmitButtonWidget(
                    isButtonActive: isButtonActive,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GetStartedWidget extends StatelessWidget {
  const _GetStartedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Get Started",
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
      ),
    );
  }
}

class _PhoneNumbersWidgets extends StatefulWidget {
  final TextEditingController myController;
  final MaskTextInputFormatter maskFormatter;
  const _PhoneNumbersWidgets({
    Key? key,
    required this.myController,
    required this.maskFormatter,
  }) : super(key: key);

  @override
  State<_PhoneNumbersWidgets> createState() => _PhoneNumbersWidgetsState();
}

class _PhoneNumbersWidgetsState extends State<_PhoneNumbersWidgets> {
  CountryCode code = codes.map(CountryCode.fromMap).toList().first;

  @override
  Widget build(BuildContext context) {
    const height = 48.0;
    const countryPicker = CountryCodePicker();
    const inputTextBoderRadius = 16.0;
    const countryImageBorderRadius = 8.0;
    const countryImageHeight = 20.0;
    const countryImageWidth = 38.0;

    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () async {
            code = await countryPicker.showPicker(context: context) ?? code;
            //if (code != null) print(code);
            setState(() {
              log("$code");
            });
          },
          child: Container(
            //width: 120,
            height: height,
            decoration: const BoxDecoration(
              color: AppColors.inactiveColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
                left: 12.0,
                top: 12.0,
                bottom: 14.0,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(countryImageBorderRadius),
                    child: SizedBox(
                      height: countryImageHeight,
                      width: countryImageWidth,
                      child: code.flagImage,
                    ),
                  ),
                  const SizedBox(width: 5),
                  UnconstrainedBox(
                    child: Text(
                      code.dialCode,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          height: 1.25,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: height,
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
              cursorColor: AppColors.textColor,
              controller: widget.myController,
              keyboardType: TextInputType.number,
              inputFormatters: [widget.maskFormatter],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(inputTextBoderRadius),
                ),
                hintText: "(123) 123-1234",
                filled: true,
                fillColor: AppColors.inactiveColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}

class _SubmitButtonWidget extends StatelessWidget {
  final bool isButtonActive;
  const _SubmitButtonWidget({
    Key? key,
    required this.isButtonActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 48.0;
    const arrowColor = Color(0xFF594C74);
    const inactiveArrowColor = Color(0xFF7886B8);

    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: isButtonActive
              ? () {
                  log("succsess login");
                }
              : null,
          child: Container(
            height: buttonSize,
            width: buttonSize,
            decoration: BoxDecoration(
              boxShadow: [
                if (isButtonActive)
                  const BoxShadow(
                    color: AppColors.shadowColor,
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              color: isButtonActive ? Colors.white : AppColors.inactiveColor,
            ),
            child: SvgPicture.asset(
              AppAssets.arrowRightSvg,
              fit: BoxFit.scaleDown,
              color: isButtonActive ? arrowColor : inactiveArrowColor,
            ),
          ),
        ),
      ),
    );
  }
}
