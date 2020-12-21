import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Offset> _objectPoints = [];
  Offset objectPoint;
  bool shouldJoinPoints = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 60,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.play_arrow),
            backgroundColor: Colors.red,
            label: 'Next',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              if (Helper.haveEnoughPoints(context, _objectPoints)) {
                print('Next');
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: shouldJoinPoints ? 'Select Points' : 'Draw Object',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => joinPoints(),
          ),
          SpeedDialChild(
            child: Icon(Icons.remove),
            backgroundColor: Colors.red,
            label: 'Reset',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                _objectPoints.clear();
                shouldJoinPoints = false;
                Helper.showFlushbar(context, 'Reset Successfully!');
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
    if (!Helper.haveEnoughPoints(context, _objectPoints)) {
      return;
    }
    setState(() {
      shouldJoinPoints = !shouldJoinPoints;
    });
  }
}
