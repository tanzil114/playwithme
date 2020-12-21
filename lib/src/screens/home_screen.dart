import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';
import 'package:playwithme/src/screens/color_interaction_screen.dart';

import '../object_painter.dart';
import 'drag_interaction_screen.dart';

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
            child: Icon(Icons.arrow_forward),
            backgroundColor: Colors.red,
            label: 'Next',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              if (Helper.haveEnoughPoints(context, _objectPoints)) {
                showDialog(
                    context: context,
                    builder: (dialogContext) => SimpleDialog(
                          title: Text('Choose an Interaction'),
                          children: [
                            ListTile(
                              title: Text('Drag'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DragInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Color'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ColorInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ));
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
          SpeedDialChild(
            child: Icon(Icons.info),
            backgroundColor: Colors.red,
            label: 'Info',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Helper.showAlertDialog(context, 'Draw Object',
                'Select at least 3 points by tapping on the screen, and press Draw Object to draw the object'),
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
