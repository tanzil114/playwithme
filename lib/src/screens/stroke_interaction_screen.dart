import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class StrokeInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const StrokeInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _StrokeInteractionScreenState createState() =>
      _StrokeInteractionScreenState();
}

class _StrokeInteractionScreenState extends State<StrokeInteractionScreen> {
  final double sliderHeight = 170;
  double _currentStroke = AppConfig.strokeWidth;

  final _appBar = AppBar(
    title: Text('Stroke Interaction'),
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
            child: Icon(Icons.info),
            backgroundColor: Colors.red,
            label: 'Info',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Helper.showAlertDialog(context, 'Stroke Interaction',
                'Adjust the slider to change stroke width of the object'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: AppConfig.backgroundColor,
          child: Column(
            children: [
              Slider(
                value: _currentStroke,
                min: AppConfig.objectStrokeMin,
                max: AppConfig.objectStrokeMax,
                divisions: AppConfig.objectStrokeMax.toInt(),
                label: _currentStroke.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentStroke = value;
                  });
                },
              ),
              CustomPaint(
                painter: ObjectPainter(
                  objectPoints: widget.objectPoints,
                  shouldJoinPoints: true,
                  strokeWidth: _currentStroke,
                ),
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
