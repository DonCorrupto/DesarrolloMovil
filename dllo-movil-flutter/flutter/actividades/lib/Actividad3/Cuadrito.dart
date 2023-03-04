import 'package:flutter/material.dart';

class Cuadrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      width: 130,
      height: 100,
      margin: const EdgeInsets.only(right: 5, top: 5, left: 5, bottom: 5),
      child: Column(
        children: [
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          Spacer(),
          Opacity(
            opacity: 0.65,
            child: Text(
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }
}
