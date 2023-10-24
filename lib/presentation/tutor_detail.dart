import 'package:flutter/material.dart';

class TutorDetail extends StatefulWidget {
  const TutorDetail({Key? key}) : super(key: key);

  @override
  State<TutorDetail> createState() => _TutorDetailState();
}

class _TutorDetailState extends State<TutorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Detail'),
      ),
      body: const Center(
        child: Text('Tutor Detail'),
      ),
    );
  }
}
