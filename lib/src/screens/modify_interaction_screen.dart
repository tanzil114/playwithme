import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class ModifyInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const ModifyInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _ModifyInteractionScreenState createState() =>
      _ModifyInteractionScreenState();
}

class _ModifyInteractionScreenState extends State<ModifyInteractionScreen> {
  List<Offset> currentObjectPoints;
  bool _removed = false;
  bool _added = false;
  final _random = new Random();

  final _appBar = AppBar(
    title: Text('Modify Interaction'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
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
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
            label: 'Add',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                if (!_added && !_removed) {
                  currentObjectPoints =
                      widget.objectPoints.map((e) => e).toList();
                }
                _added = true;
                currentObjectPoints.add(Offset(
                    next(0, MediaQuery.of(context).size.width),
                    next(0, MediaQuery.of(context).size.height)));
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.remove),
            backgroundColor: Colors.red,
            label: 'Remove',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                if (!_added && !_removed) {
                  currentObjectPoints =
                      widget.objectPoints.map((e) => e).toList();
                }
                _removed = true;
                if (currentObjectPoints.length > 3) {
                  currentObjectPoints.removeLast();
                } else {
                  Helper.showFlushbar(context, 'Not enought points!');
                }
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.info),
            backgroundColor: Colors.red,
            label: 'Info',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Helper.showAlertDialog(context, 'Modify Interaction',
                'Add random or Remove last element of the object by selecting Add or Remove button from options'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints: _added || _removed
                  ? currentObjectPoints
                  : widget.objectPoints,
              shouldJoinPoints: true,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }

  double next(double min, double max) =>
      (min + _random.nextInt(max.toInt() - min.toInt())).toDouble();
}
