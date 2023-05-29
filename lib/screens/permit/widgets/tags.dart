import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.only(right: 5, bottom: 5),
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Expired',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5, bottom: 5),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'NPI',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 5, bottom: 5),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'NPW',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
