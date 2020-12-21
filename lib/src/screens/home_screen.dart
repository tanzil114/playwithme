import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Offset> _objectPoints = [];
  Offset objectPoint;
  bool shouldJoinPoints = false;
  String _dropDownValue = 'Drag';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: shouldJoinPoints ? 'Select Points' : 'Draw Object',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => joinPoints(),
          ),
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: 'Reset',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _objectPoints.clear();
                shouldJoinPoints = false;
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTapDown: (details) {
          if (!shouldJoinPoints) {
            setState(() {
              _objectPoints.add(details.globalPosition);
            });
          }
        },
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints: _objectPoints,
              shouldJoinPoints: shouldJoinPoints,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }

  void joinPoints() {
    setState(() {
      shouldJoinPoints = !shouldJoinPoints;
    });
  }

  void dragObject() {
    print('dragObject :/');
  }
}

class ObjectPainter extends CustomPainter {
  ObjectPainter({this.objectPoints, this.shouldJoinPoints});
  final List<Offset> objectPoints;
  final bool shouldJoinPoints;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppConfig.objectColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1);
    var objectPaint = Paint()..color = AppConfig.objectColor;
    if (!shouldJoinPoints) {
      objectPoints.forEach((e) {
        canvas.drawCircle(e, 5.0, paint);
      });
    } else {
      drawObject(canvas, objectPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawObject(Canvas canvas, Paint paint) {
    if (objectPoints == null ||
        objectPoints.isEmpty ||
        objectPoints.length <= 2) {
      print('Not enough points');
      return;
    }
    var path = Path()..moveTo(objectPoints.first.dx, objectPoints.first.dy);
    for (int i = 1; i < objectPoints.length - 1; ++i) {
      path.lineTo(objectPoints[i].dx, objectPoints[i].dy);
    }
    path.lineTo(objectPoints.last.dx, objectPoints.last.dy);
    path.close();
    canvas.drawPath(path, paint);
  }
}
