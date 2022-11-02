import 'package:flutter/material.dart';

import 'app_button.dart';

class AppDialogs {
  Future<T?> showCustomDialog<T>(
      BuildContext context, WidgetBuilder dialogContentWidget) {
    // set up the AlertDialog
    Widget alert(BuildContext context) => AlertDialog(
          content: dialogContentWidget(context),
          insetPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(24.0),
          titlePadding: EdgeInsets.zero,
        );

    // show the dialog
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xCC09171F),
      builder: alert,
    );
  }

  Future<T?> showDefaultDialog<T>(
      BuildContext context, String title, WidgetBuilder dialogContentWidget) {
    Widget alert(BuildContext context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              dialogContentWidget(context),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: BaseUIButton(
                      onPressed: null,
                      loading: false,
                      buttonText: 'Cancel',
                      color: Color(0x1436470D),
                      borderColor: Color(0xFF143647),
                      buttonRadius: 21,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: BaseUIButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      loading: false,
                      buttonText: 'Confirm',
                      buttonRadius: 21,
                    ),
                  )
                ],
              ),
            ],
          ),
          insetPadding: const EdgeInsets.all(30.0),
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(30.0),
          titlePadding: EdgeInsets.zero,
        );

    // show the dialog
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xCC09171F),
      builder: alert,
    );
  }
}
