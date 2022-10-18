import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    Key? key,
    required this.length,
    required this.pinCodeController,
    required this.errorAnimationController,
    required this.errorController,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF143647),
    required this.onChanged,
  }) : super(key: key);

  final int length;
  final TextEditingController pinCodeController;
  final StreamController<ErrorAnimationType> errorAnimationController;
  final StreamController<Object?> errorController;
  final TextStyle textStyle;
  final Color fillColor;
  final Color borderColor;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: textStyle,
        length: length,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
        scrollPadding: EdgeInsets.zero,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: fillColor,
          selectedFillColor: fillColor,
          inactiveColor: borderColor,
          errorBorderColor: borderColor,
          activeColor: borderColor,
          inactiveFillColor: fillColor,
          selectedColor: borderColor,
          borderRadius: BorderRadius.circular(10.0),
          borderWidth: 0.2,
        ),
        cursorColor: Colors.black.withOpacity(0.3),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        textStyle: const TextStyle(fontSize: 14, color: Colors.black),
        hintStyle: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.3)),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        controller: pinCodeController,
        errorAnimationController: errorAnimationController,
        keyboardType: TextInputType.number,
        hintCharacter: '0',
        boxShadows: const [
          BoxShadow(
              offset: Offset(0, 1),
              color: Color(0x0B222C1A),
              blurRadius: 3,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal)
        ],
        onCompleted: (v) {
          FocusScope.of(context).unfocus();
        },
        onChanged: onChanged,
      ),
    );
  }
}
