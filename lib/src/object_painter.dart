import 'package:flutter/material.dart';
import 'constants/app_config.dart';

class ObjectPainter extends CustomPainter {
  ObjectPainter(
      {this.objectPoints,
      this.shouldJoinPoints,
      this.objectColor = AppConfig.objectColor,
      this.shouldBrushPaint = false,
      this.brushContactPoints,
      this.brushColor});
  final List<Offset> objectPoints;
  final bool shouldJoinPoints;
  final Color objectColor;
  final bool shouldBrushPaint;
  final List<Offset> brushContactPoints;
  final Color brushColor;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppConfig.objectColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1);
    var objectPaint = Paint()..color = objectColor;
    if (!shouldJoinPoints) {
      objectPoints.forEach((e) {
        canvas.drawCircle(e, AppConfig.objectPointRadius, paint);
      });
    } else {
      drawObject(canvas, objectPaint);
    }
    if (shouldBrushPaint) {
      var brushPaint = Paint()..color = brushColor;
      brushContactPoints.forEach((e) {
        canvas.drawCircle(e, AppConfig.brushRadius, brushPaint);
      });
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawObject(Canvas canvas, Paint paint) {
    var path = Path()..moveTo(objectPoints.first.dx, objectPoints.first.dy);
    for (int i = 1; i < objectPoints.length - 1; ++i) {
      path.lineTo(objectPoints[i].dx, objectPoints[i].dy);
    }
    path.lineTo(objectPoints.last.dx, objectPoints.last.dy);
    path.close();
    canvas.drawPath(path, paint);
  }
}
