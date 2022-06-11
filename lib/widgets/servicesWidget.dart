import 'dart:ui';

import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  String text;
  IconData icon;
  Color color;
  String imageUrl;
  ServiceWidget(
    this.imageUrl,
    this.icon, {
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        elevation: 5,
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              imageUrl != ""
                  ? Container(
                      height: 50,
                      width: 60,
                      child: Image.asset(imageUrl),
                    )
                  : Icon(icon),
              Spacer(),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
