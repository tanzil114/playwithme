import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/color_picker_handler.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class GradientInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const GradientInteractionScreen({Key key, this.objectPoints})
      : super(key: key);
  @override
  _GradientInteractionScreenState createState() =>
      _GradientInteractionScreenState();
}

class _GradientInteractionScreenState extends State<GradientInteractionScreen> {
  Color pickerColor1 = AppConfig.objectColor;
  Color currentColor1 = AppConfig.objectColor;
  Color pickerColor2 = AppConfig.objectColor;
  Color currentColor2 = AppConfig.objectColor;

  void changeColor1(Color color) {
    setState(() => pickerColor1 = color);
  }

  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Interaction'),
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
            child: Icon(Icons.colorize),
            backgroundColor: Colors.red,
            label: 'Color1',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => ColorPickerHandler.showColorPickerDialog(
                context: context,
                pickerColor: pickerColor1,
                currentColor: currentColor1,
                changeColor: changeColor1,
                onPressed: () {
                  setState(() => currentColor1 = pickerColor1);
                  Navigator.of(context).pop();
                }),
          ),
          SpeedDialChild(
            child: Icon(Icons.colorize),
            backgroundColor: Colors.red,
            label: 'Color2',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => ColorPickerHandler.showColorPickerDialog(
                context: context,
                pickerColor: pickerColor2,
                currentColor: currentColor2,
                changeColor: changeColor2,
                onPressed: () {
                  setState(() => currentColor2 = pickerColor2);
                  Navigator.of(context).pop();
                }),
          ),
          SpeedDialChild(
            child: Icon(Icons.info),
            backgroundColor: Colors.red,
            label: 'Info',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Helper.showAlertDialog(context, 'Color Interaction',
                'Use both color pickers from the options menu to add gradient to the object'),
          ),
        ],
      ),
      body: GestureDetector(
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints: widget.objectPoints,
              shouldJoinPoints: true,
              gradientColorList: [currentColor1, currentColor2],
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
