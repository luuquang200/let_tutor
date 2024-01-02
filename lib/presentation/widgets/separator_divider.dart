import 'package:flutter/material.dart';

class SeparatorDivider extends StatelessWidget {
  final double marginLeft;
  final double marginRight;

  const SeparatorDivider(
      {super.key, this.marginLeft = 8.0, this.marginRight = 8.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: marginLeft, right: marginRight, top: 8, bottom: 8),
      child:
          const Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
    );
  }
}
