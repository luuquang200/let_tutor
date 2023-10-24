import 'package:flutter/material.dart';

class Specialities extends StatelessWidget {
  const Specialities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          backgroundColor: Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            "IELTS",
            style: TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        ),
        Chip(
          backgroundColor: Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            "TOEFL",
            style: TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        ),
        Chip(
          backgroundColor: Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            "TOEIC",
            style: TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        ),
        Chip(
          backgroundColor: Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            "GRE",
            style: TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        ),
        Chip(
          backgroundColor: Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            "GMAT",
            style: TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        ),
      ],
    );
  }
}
