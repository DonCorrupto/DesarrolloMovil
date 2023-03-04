import 'package:flutter/material.dart';

class Superior extends StatelessWidget {
  late String _url;

  Superior(String url) {
    _url = url;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 80, bottom: 10, left: 50),
          //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Image.network(_url),
        ),
        Container(
            margin: const EdgeInsets.only(left: 100, top: 145),
            //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )
              ],
            ))
      ],
    );
  }
}
