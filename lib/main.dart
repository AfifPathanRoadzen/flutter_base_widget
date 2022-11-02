import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_widget/app_dialog.dart';
import 'package:flutter_base_widget/country_picker_entry_field.dart';
import 'package:flutter_base_widget/pin_code_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Mobile Entry Field Country Picker
  bool isLoading = false;
  FocusNode mobileNumberFocusNode = FocusNode();
  final TextEditingController _numberController = TextEditingController();
  String _number = '';

  // Otp Entry Field Picker
  TextEditingController otpController = TextEditingController();
  String otp = '';
  bool isLoadingOtp = false;
  late StreamController<ErrorAnimationType> errorAnimationController;
  late StreamController<Object?> errorController;

  @override
  void initState() {
    errorAnimationController = StreamController<ErrorAnimationType>();
    errorController = StreamController<Object?>.broadcast();
    errorController.stream.listen((event) {
      if (event != null) {
        errorAnimationController.add(ErrorAnimationType.shake);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _numberController.dispose();
    otpController.dispose();
    errorController.close();
    errorAnimationController.close();
    super.dispose();
  }

  void _phoneCallAction() {
    setState(() {
      isLoadingSetup(loading: true);
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _numberController.text = '';
        _number = '';
        isLoadingSetup(loading: false);
      });
    });
  }

  void _otpAction() {
    setState(() {
      isLoadingOtpSetup(loading: true);
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (otp == '000000') {
          errorController.add(() => 'Invalid PassCode');
        } else {
          otpController.text = '';
          otp = '';
           AppDialogs().showDefaultDialog(
            context,
            "Set Fleet Status to Inactive?",
                (context) => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      '•',
                      style: TextStyle(
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        'All of your current services would be stopped.',
                        style: TextStyle(
                          fontSize: 14,),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      '•',
                      style: TextStyle(
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        'Until the status is changed to active, you won’t get any new service requests.',
                        style: TextStyle(
                          fontSize: 14,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        isLoadingOtpSetup(loading: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CountryPickerEntryField(
              hint: "Enter Mobile Number",
              controller: _numberController,
              textInputType: const TextInputType.numberWithOptions(),
              maxLength: 10,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                setState(() {
                  _number = value;
                });
              },
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              focusNode: mobileNumberFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            BaseUIButton(
              onPressed: isLoading || _number.length != 10
                  ? null
                  : () async {
                      _phoneCallAction();
                    },
              loading: isLoading,
              buttonText: 'Get OTP',
            ),
            const SizedBox(
              height: 100.0,
            ),
            OtpField(
              length: 6,
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
              errorAnimationController: errorAnimationController,
              errorController: errorController,
              pinCodeController: otpController,
            ),
            StreamBuilder<Object?>(
              stream: errorController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  var data = snapshot.data;
                  if (data is String Function()) {
                    data = data.call();
                  }
                  return Text(
                    data.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            BaseUIButton(
              onPressed: isLoadingOtp || otp.length != 6
                  ? null
                  : () async {
                      _otpAction();
                    },
              loading: isLoadingOtp,
              buttonText: 'Verify',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void isLoadingSetup({required bool loading}) => setState(() {
        isLoading = loading; //Disable Progressbar
      });

  void isLoadingOtpSetup({required bool loading}) => setState(() {
        isLoadingOtp = loading; //Disable Progressbar
      });
}
