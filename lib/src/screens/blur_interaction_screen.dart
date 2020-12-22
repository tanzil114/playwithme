import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class BlurInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const BlurInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _BlurInteractionScreenState createState() => _BlurInteractionScreenState();
}

class _BlurInteractionScreenState extends State<BlurInteractionScreen> {
  final double sliderHeight = 170;
  double _currentBlurSigma = 0.0;

  final _appBar = AppBar(
    title: Text('Blur Interaction'),
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
            onTap: () => Helper.showAlertDialog(context, 'Blur Interaction',
                'Adjust the slider to change blurriness of the object'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: AppConfig.backgroundColor,
          child: Column(
            children: [
              Slider(
                value: _currentBlurSigma,
                min: AppConfig.objectBlurSigmaMin,
                max: AppConfig.objectBlurSigmaMax,
                divisions: AppConfig.objectBlurSigmaMax.toInt(),
                label: _currentBlurSigma.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentBlurSigma = value;
                  });
                },
              ),
              CustomPaint(
                painter: ObjectPainter(
                  objectPoints: widget.objectPoints,
                  shouldJoinPoints: true,
                  objectBlurSigma: _currentBlurSigma,
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
