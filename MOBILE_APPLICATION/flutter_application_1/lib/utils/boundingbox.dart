import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<dynamic> detectedObjects;
  final Size imageSize;

  BoundingBoxPainter(this.detectedObjects, this.imageSize);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / imageSize.width;
    final double scaleY = size.height / imageSize.height;

    for (var detectedObject in detectedObjects) {
      final List<dynamic> box = detectedObject['box'];
      final double left = box[0] * scaleX;
      final double top = box[1] * scaleY;
      final double right = box[2] * scaleX;
      final double bottom = box[3] * scaleY;

      final Rect rect = Rect.fromLTRB(left, top, right, bottom);
      final Paint paint = Paint()
        ..color = getColorForTag(
            detectedObject['tag'].toString()) // Choose your box color here
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;

      canvas.drawRect(rect, paint);

      final TextPainter painter = TextPainter(
        text: TextSpan(
          text: detectedObject['tag'].toString(),
          style: TextStyle(
              color: getColorForTag(
                detectedObject['tag'].toString(),
              ),
              fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );

      painter.layout();
      final textLeft = left + 5;
      final textTop = top + 5;

      painter.paint(canvas, Offset(textLeft, textTop));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}