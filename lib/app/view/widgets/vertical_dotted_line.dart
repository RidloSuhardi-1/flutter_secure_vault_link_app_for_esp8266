import 'package:flutter/material.dart';


class VerticalDottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  const VerticalDottedLine({super.key, 
    this.height = 100.0,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _VerticalDottedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      size: Size(strokeWidth, height),
    );
  }
}

class _VerticalDottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _VerticalDottedLinePainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final maxCount = (size.height / (dashWidth + dashSpace)).ceil();
    final path = Path();

    for (int i = 0; i < maxCount; i++) {
      final startY = i * (dashWidth + dashSpace);
      final endY = startY + dashWidth;
      path.moveTo(0, startY);
      path.lineTo(0, endY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_VerticalDottedLinePainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        dashWidth != oldDelegate.dashWidth ||
        dashSpace != oldDelegate.dashSpace;
  }
}
