import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/widgets/tutor_information_card.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({Key? key}) : super(key: key);
  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  final specialities = [
    'All',
    'English for kids',
    'English for Business',
    'Conversational',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];
  int selectedSpecialityIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tutor'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 250,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Upcoming lesson.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text("Enter lesson room"),
                        icon: const Icon(Icons.play_circle_fill_outlined)),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Text(
                        'Total lesson time is 507 hours 5 minutes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child:
                          Text('Find a tutor', style: TextStyle(fontSize: 24)),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 220,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter a tutor name',
                                hintStyle: TextStyle(
                                  color: Color(0xFFB0B0B0),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            )),
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Select tutor nationality',
                                hintStyle: TextStyle(
                                  color: Color(0xFFB0B0B0),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            )),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Select available tutoring time:',
                          style: TextStyle(fontSize: 18)),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: TextField(),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 5,
                        children: List<Widget>.generate(
                          specialities.length,
                          (index) => ChoiceChip(
                            label: Text(specialities[index]),
                            selectedColor: Theme.of(context).primaryColor,
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedSpecialityIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            selected: selectedSpecialityIndex == index,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedSpecialityIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedSpecialityIndex = 0;
                          });
                        },
                        child: const Text('Reset Filters'),
                      ),
                    ),
                    Container(
                      height: 600, // Set a fixed height for the container
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const TutorInformationCard(),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
