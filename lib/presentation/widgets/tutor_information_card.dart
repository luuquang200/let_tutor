import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class TutorInformationCard extends StatelessWidget {
  const TutorInformationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Routes.navigateTo(context, Routes.tutorDetail);
        },
        child: Card(
          elevation: 5,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xFF0058C6),
                  ),
                ),
              ),
              // Column
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Avatar
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/tutor_avatar.jpg'),
                          radius: 44,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              "Adelia Rice",
                              style: CustomTextStyle.headlineLarge,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/flags/Foreigner.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'United States',
                                  style: CustomTextStyle.bodyRegular,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            // row
                            Row(
                                children: List<Widget>.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Specialities",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          backgroundColor: Color(0xFFDDEAFF),
                          side: BorderSide.none,
                          label: Text(
                            "IELTS",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF0058C6)),
                          ),
                        ),
                        Chip(
                          backgroundColor: Color(0xFFDDEAFF),
                          side: BorderSide.none,
                          label: Text(
                            "TOEFL",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF0058C6)),
                          ),
                        ),
                        Chip(
                          backgroundColor: Color(0xFFDDEAFF),
                          side: BorderSide.none,
                          label: Text(
                            "TOEIC",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF0058C6)),
                          ),
                        ),
                        Chip(
                          backgroundColor: Color(0xFFDDEAFF),
                          side: BorderSide.none,
                          label: Text(
                            "GRE",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF0058C6)),
                          ),
                        ),
                        Chip(
                          backgroundColor: Color(0xFFDDEAFF),
                          side: BorderSide.none,
                          label: Text(
                            "GMAT",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF0058C6)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.'),
                    const SizedBox(
                      height: 44,
                    ),
                  ],
                ),
              ),
              // Book button
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    // icon: book tutor
                    icon: const Icon(Icons.edit_calendar),
                    label: const Text("Book"),
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Color(0xFF0058C6), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
