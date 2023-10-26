import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            Image.asset('assets/course_img_url.png'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Life in the Internet Age',
                      style: CustomTextStyle.headlineLarge),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Let's discuss how technology is changing the way we live",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Intermediate",
                        style: TextStyle(fontSize: 18),
                      )),
                      Text(
                        '9 lessons',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
