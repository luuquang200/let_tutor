import 'package:flutter/material.dart';

class TutorInformationCard extends StatelessWidget {
  const TutorInformationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFBEBEBE),
          width: 1,
        ),
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
                // Information tutor
                Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text('AB'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text("Adelia Rice"),
                        Text("France"),
                        // row
                        Row(
                            children: List<Widget>.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ))

                        // Rating star
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),

                Text(
                  "Specialities",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
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
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
                      ),
                    ),
                    Chip(
                      backgroundColor: Color(0xFFDDEAFF),
                      side: BorderSide.none,
                      label: Text(
                        "TOEFL",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
                      ),
                    ),
                    Chip(
                      backgroundColor: Color(0xFFDDEAFF),
                      side: BorderSide.none,
                      label: Text(
                        "TOEIC",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
                      ),
                    ),
                    Chip(
                      backgroundColor: Color(0xFFDDEAFF),
                      side: BorderSide.none,
                      label: Text(
                        "GRE",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
                      ),
                    ),
                    Chip(
                      backgroundColor: Color(0xFFDDEAFF),
                      side: BorderSide.none,
                      label: Text(
                        "GMAT",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
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
          Positioned(
              bottom: 8,
              right: 8,
              child: OutlinedButton.icon(
                onPressed: () {},
                // icon: book tutor
                icon: const Icon(Icons.edit_calendar),
                label: const Text("Book"),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0058C6), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
