import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/color_picker_handler.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class BrushInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const BrushInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _BrushInteractionScreenState createState() => _BrushInteractionScreenState();
}

class _BrushInteractionScreenState extends State<BrushInteractionScreen> {
  List<Offset> _brushPoints = [];
  Color pickerColor = AppConfig.brushColor;
  Color currentColor = AppConfig.brushColor;
  final _appBar = AppBar(
    title: Text('Brush Interaction'),
  );

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

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
            child: Icon(Icons.colorize),
            backgroundColor: Colors.red,
            label: 'Color',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => ColorPickerHandler.showColorPickerDialog(
                context: context,
                pickerColor: pickerColor,
                currentColor: currentColor,
                changeColor: changeColor,
                onPressed: () {
                  setState(() => currentColor = pickerColor);
                  Navigator.of(context).pop();
                }),
          ),
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
            onTap: () => Helper.showAlertDialog(context, 'Brush Interaction',
                'Use the brush to paint over the object, and change color from the options'),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _brushPoints.add(details.globalPosition -
                Offset(0, _appBar.preferredSize.height));
          });
        },
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints: widget.objectPoints,
              shouldJoinPoints: true,
              shouldBrushPaint: true,
              brushContactPoints: _brushPoints,
              brushColor: currentColor,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
