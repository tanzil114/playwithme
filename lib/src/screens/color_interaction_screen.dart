import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/color_picker_handler.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class ColorInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const ColorInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _ColorInteractionScreenState createState() => _ColorInteractionScreenState();
}

class _ColorInteractionScreenState extends State<ColorInteractionScreen> {
  Color pickerColor = AppConfig.objectColor;
  Color currentColor = AppConfig.objectColor;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
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
            onTap: () => Helper.showAlertDialog(context, 'Color Interaction',
                'Use the color picker from the options menu to color the object'),
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
              objectColor: currentColor,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
