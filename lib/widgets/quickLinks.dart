import 'package:flutter/material.dart';
import 'package:fua/widgets/servicesWidget.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          const Divider(),
          const Text(
            "Services",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ServiceWidget(
                "img/wash1.jpeg",
                Icons.chair,
                text: "Sofa Cleaning",
                color: Colors.blue,
              ),
              ServiceWidget(
                "img/wash2.jpeg",
                Icons.chair,
                text: "Carpet Cleaning",
                color: Color.fromARGB(255, 183, 3, 238),
              ),
              ServiceWidget(
                "img/wash3.jpeg",
                Icons.chair,
                text: "General Laundry",
                color: Color.fromARGB(255, 248, 143, 6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
