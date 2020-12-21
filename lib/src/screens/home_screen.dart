import 'package:flutter/material.dart';
import 'package:playwithme/src/constants/app_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset _lineStartPoint = Offset(0, 0), _lineEndPoint = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          _lineStartPoint = details.globalPosition;
        },
        onPanUpdate: (details) {
          setState(() {
            _lineEndPoint = details.globalPosition;
          });
        },
        // onPanStart: (details) {
        //   _lineStartPoint = details.globalPosition;
        // },
        // onPanEnd: (details) {
        //   _lineStartPoint = details.globalPosition;
        //   setState(() {});
        // },
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              lineStartPoint: _lineStartPoint,
              lineEndPoint: _lineEndPoint,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class ObjectPainter extends CustomPainter {
  ObjectPainter({
    this.lineStartPoint,
    this.lineEndPoint,
  });
  final Offset lineStartPoint;
  final Offset lineEndPoint;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppConfig.objectColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    // Offset startingPoint = Offset(0, size.height / 2);
    // Offset endingPoint = Offset(size.width - 10, size.height / 2);
    print('$lineStartPoint, $lineEndPoint');
    canvas.drawLine(lineStartPoint, lineEndPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
