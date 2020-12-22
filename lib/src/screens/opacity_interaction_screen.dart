import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class OpacityInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const OpacityInteractionScreen({Key key, this.objectPoints})
      : super(key: key);
  @override
  _OpacityInteractionScreenState createState() =>
      _OpacityInteractionScreenState();
}

class _OpacityInteractionScreenState extends State<OpacityInteractionScreen> {
  final double sliderHeight = 170;
  double _currentOpacity = AppConfig.objectOpacity;

  final _appBar = AppBar(
    title: Text('Opacity Interaction'),
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
            onTap: () => Helper.showAlertDialog(context, 'Opacity Interaction',
                'Adjust the slider to change opacity of the object'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: AppConfig.backgroundColor,
          child: Column(
            children: [
              Slider(
                value: _currentOpacity,
                min: AppConfig.objectOpacityMin,
                max: AppConfig.objectOpacityMax,
                divisions: AppConfig.objectOpacityMax.toInt(),
                label: _currentOpacity.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentOpacity = value;
                  });
                },
              ),
              CustomPaint(
                painter: ObjectPainter(
                  objectPoints: widget.objectPoints,
                  shouldJoinPoints: true,
                  objectOpacity: _currentOpacity,
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
