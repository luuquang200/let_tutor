import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_chip.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/specialities.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tutor Information
            Row(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/tutor_avatar.jpg'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text("Adelia Rice", style: CustomTextStyle.headlineLarge),
                    Text("France", style: const TextStyle(fontSize: 18)),
                    // row
                    Row(
                        children: List<Widget>.generate(
                      5,
                      (index) => const Icon(Icons.star, color: Colors.amber),
                    ))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
                'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.'),
            const SizedBox(
              height: 16,
            ),

            // Buttons: Favorite, Report and Review
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    children: [Icon(Icons.favorite_outline), Text('Favorite')],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    children: [Icon(Icons.report_outlined), Text('Report')],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.rate_review_outlined),
                      Text('Review')
                    ],
                  ),
                ),
              ],
            ),

            // Introduction Video
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Text(
                'Introduction Video',
                style: CustomTextStyle.headlineMedium,
              ),
            ),

            // Languages
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Languages',
              style: CustomTextStyle.headlineMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomChip(
              label: "English",
            ),

            // Specialities
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Specialities',
              style: CustomTextStyle.headlineMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Specialities(),

            //Suggested courses
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Suggested Courses',
              style: CustomTextStyle.headlineMedium,
            ),
            _suggestedCourses(),
          ],
        ),
      ),
    );
  }

  Widget _suggestedCourses() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Text(
              'Life in the Internet Age:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Link'),
            )
          ],
        );
      },
    );
  }
}
