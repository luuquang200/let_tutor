import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class TopicDetail extends StatefulWidget {
  const TopicDetail({super.key});

  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Topic detail', style: CustomTextStyle.topHeadline),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
        body: SingleChildScrollView(
          child: Column(children: [
            // Course cover photo
            Image.asset('assets/course_img_url.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _introductionInfo(),
                  const SizedBox(height: 12),
                  // PDF Viewer
                  const Text('PDF viewer'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Placeholder(),
                ],
              ),
            ),
          ]),
        ));
  }

  _introductionInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The Internet', style: CustomTextStyle.titleLarge),
        SizedBox(height: 12),
        Text(
          "Let's discuss how technology is changing the way we live",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
