import 'package:flutter/material.dart';

class BaseUIButton extends StatelessWidget {
  const BaseUIButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.height = 48,
      this.buttonRadius = 27.0,
      this.color = const Color(0xFFEC6F3A),
      this.loading = false});

  final Future<void> Function()? onPressed;
  final String buttonText;
  final bool loading;
  final double height;
  final Color color;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
          ),
          onPressed: onPressed == null || loading
              ? null
              : () async {
                  try {
                    await onPressed?.call();
                  } catch (e) {
                    rethrow;
                  }
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonText),
              if (loading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: Theme.of(context).textTheme.button?.fontSize,
                    width: Theme.of(context).textTheme.button?.fontSize,
                    child: CircularProgressIndicator(
                      color: color,
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
