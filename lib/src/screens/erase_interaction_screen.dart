import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:playwithme/src/constants/app_config.dart';
import 'package:playwithme/src/helper/helper.dart';

import '../object_painter.dart';

class EraseInteractionScreen extends StatefulWidget {
  final List<Offset> objectPoints;
  const EraseInteractionScreen({Key key, this.objectPoints}) : super(key: key);
  @override
  _EraseInteractionScreenState createState() => _EraseInteractionScreenState();
}

class _EraseInteractionScreenState extends State<EraseInteractionScreen> {
  List<Offset> _erasePoints = [];
  final _appBar = AppBar(
    title: Text('Erase Interaction'),
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
            onTap: () => Helper.showAlertDialog(context, 'Erase Interaction',
                'Use the eraser to erase the object'),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _erasePoints.add(details.globalPosition -
                Offset(0, _appBar.preferredSize.height));
          });
        },
        child: Container(
          color: AppConfig.backgroundColor,
          child: CustomPaint(
            painter: ObjectPainter(
              objectPoints: widget.objectPoints,
              shouldJoinPoints: true,
              erasePoints: _erasePoints,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
