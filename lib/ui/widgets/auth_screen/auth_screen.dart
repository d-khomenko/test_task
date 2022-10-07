// ignore_for_file: public_member_api_docs
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_task/resources/app_assets.dart';
import 'package:test_task/ui/theme/app_colors.dart';
import 'package:test_task/ui/widgets/auth_screen/auth_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
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
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 48, left: 20),
                  child: _GetStartedWidget(),
                ),
                SizedBox(height: 160),
                _PhoneNumbersWidgets(),
                Expanded(
                  child: _SubmitButtonWidget(),
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

class _PhoneNumbersWidgets extends StatelessWidget {
  const _PhoneNumbersWidgets({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    final code = context.select((AuthModel model) => model.code);
    const height = 48.0;
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
          onTap: () => model.onCountryCodePickerTap(context),
          child: Container(
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
              controller: model.controller,
              keyboardType: TextInputType.number,
              inputFormatters: [model.maskFormatter],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(inputTextBoderRadius),
                ),
                hintText: "(123) 123-1234",
                filled: true,
                fillColor: AppColors.inactiveColor,
              ),
              onChanged: model.onEnteringPhoneNumber,
            ),
          ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}

class _SubmitButtonWidget extends StatelessWidget {
  const _SubmitButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 48.0;
    const arrowColor = Color(0xFF594C74);
    const inactiveArrowColor = Color(0xFF7886B8);

    final isButtonActive = context.select(
      (AuthModel model) => model.isButtonActive,
    );

    return GestureDetector(
      onTap: isButtonActive
          ? () {
              log("Succsess login");
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20),
        child: Align(
          alignment: Alignment.bottomRight,
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
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SvgPicture.asset(
                  AppAssets.arrowRightSvg,
                  fit: BoxFit.scaleDown,
                  color: isButtonActive ? arrowColor : inactiveArrowColor,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => log("Done"),
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
