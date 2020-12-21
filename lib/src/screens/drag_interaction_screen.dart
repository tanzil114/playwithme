import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class DragInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const DragInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _DragInteractionScreenState createState() => _DragInteractionScreenState();
}

class _DragInteractionScreenState extends State<DragInteractionScreen> {
  List<Offset> variableObjectPoints = [];
  bool _isDragged = false;
  Offset prevPoint, currPoint;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Interaction'),
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 60,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.arrow_back),
            backgroundColor: Colors.red,
            label: 'Back',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.pop(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.info),
            backgroundColor: Colors.red,
            label: 'Info',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Helper.showAlertDialog(context, 'Drag Interaction',
                'Place your finger on the object and move it to drag the object'),
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: (details) {
          prevPoint = details.globalPosition;
        },
        onPanUpdate: (details) {
          currPoint = details.globalPosition;
          var diffPoint = currPoint - prevPoint;
          _isDragged = true;
          setState(() {
            variableObjectPoints.clear();
            widget.objectPoints.forEach((e) {
              variableObjectPoints.add(e + diffPoint);
            });
          });
        },
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints:
                  !_isDragged ? widget.objectPoints : variableObjectPoints,
              shouldJoinPoints: true,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
