import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  String label;
  String value;
   ProfileCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: Container(
            color: Color.fromARGB(255, 253, 248, 248),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Text(
                  label,
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
