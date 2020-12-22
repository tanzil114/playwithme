import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';
import 'package:playwithme/src/screens/color_interaction_screen.dart';
import 'package:playwithme/src/screens/stroke_interaction_screen.dart';

import '../object_painter.dart';
import 'blur_interaction_screen.dart';
import 'brush_interaction_screen.dart';
import 'drag_interaction_screen.dart';
import 'erase_interaction_screen.dart';
import 'gradient_interaction_screen.dart';
import 'modify_interaction_screen.dart';
import 'opacity_interaction_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Offset> _objectPoints = [];
  Offset objectPoint;
  bool shouldJoinPoints = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showAlertDialog();
    });
    super.initState();
  }

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
                            ListTile(
                              title: Text('Brush'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BrushInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Erase'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EraseInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Blur'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlurInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Gradient'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GradientInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Opacity'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OpacityInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Stroke'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StrokeInteractionScreen(
                                      objectPoints: _objectPoints,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Modify'),
                              onTap: () {
                                Navigator.pop(dialogContext);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ModifyInteractionScreen(
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
            onTap: () => _showAlertDialog(),
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

  void _showAlertDialog() {
    Helper.showAlertDialog(context, 'Draw Object',
        'Select at least 3 points by tapping on the screen, and press Draw Object to draw the object');
  }
}
