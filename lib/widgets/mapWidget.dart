import 'package:flutter/material.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({ Key? key }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Hello"),
      decoration: BoxDecoration(color: Colors.amber,),

    );
  }
}