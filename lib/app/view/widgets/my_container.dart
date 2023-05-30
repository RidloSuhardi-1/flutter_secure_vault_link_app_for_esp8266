import 'package:flutter/material.dart';
import 'package:iot_keamanan_barang_app/res/colors/color.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    this.padding,
    this.margin,
    this.enableBorder = true,
    required this.child,
  });

  final Widget? child;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: enableBorder
            ? Border.all(color: kSecondaryColor, width: 1.0)
            : null,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: child,
    );
  }
}
