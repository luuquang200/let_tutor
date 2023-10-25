import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/tutor_avatar.jpg'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Adelia Rice',
                        style: CustomTextStyle.headlineLarge),
                    Text('288 days ago'),
                    Row(
                        children: List<Widget>.generate(
                      5,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                    ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'I appreciated the tutors willingness to answer my questions, but I would have liked more feedback on my progress.',
            ),
          ],
        ),
      ),
    );
  }
}
