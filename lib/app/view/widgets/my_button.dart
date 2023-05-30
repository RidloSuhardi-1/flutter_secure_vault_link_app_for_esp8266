import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.foregroundColor = Colors.white,
    this.backgroundColor = Colors.blue,
  });

  final Widget? child;
  final VoidCallback? onPressed;

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),
      child: child,
    );
  }
}
