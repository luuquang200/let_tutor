import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
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
  final dateController = TextEditingController();
  int selectedSpecialityIndex = 0;
  List<String> listNationalities = <String>['Vietnamese', 'Foreigner'];
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

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
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Find a tutor',
                        style: CustomTextStyle.headlineMedium,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                            width: 220,
                            // height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.type_specimen_outlined),
                                hintText: 'Enter a tutor name',
                                hintStyle: TextStyle(
                                  color: Color(0xFFB0B0B0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 160,
                          // height: 50,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            isExpanded: true,
                            value: listNationalities.first,
                            items: listNationalities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/flags/$value.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(value),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Select available tutoring time:',
                          style: CustomTextStyle.headlineMedium),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'dd/MM/yyyy',
                              hintStyle: TextStyle(
                                color: Color(0xFFB0B0B0),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            controller: dateController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                dateController.text = DateFormat('dd/MM/yyyy')
                                    .format(selectedDate);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: startTimeController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.access_time),
                              hintText: 'Start time',
                              hintStyle: TextStyle(
                                color: Color(0xFFB0B0B0),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                helpText: 'Select start time',
                              );
                              if (selectedTime != null && mounted) {
                                startTimeController.text =
                                    selectedTime.format(context);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TextField(
                          controller: endTimeController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.timelapse),
                            hintText: 'End time',
                            hintStyle: TextStyle(
                              color: Color(0xFFB0B0B0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              helpText: 'Select end time',
                            );
                            if (selectedTime != null && mounted) {
                              endTimeController.text =
                                  selectedTime.format(context);
                            }
                          },
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Select speciality:',
                        style: CustomTextStyle.headlineMedium),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 5,
                        children: List<Widget>.generate(
                          specialities.length,
                          (index) => ChoiceChip(
                            label: Text(
                              specialities[index],
                              style: TextStyle(
                                color: selectedSpecialityIndex == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.black54,
                              ),
                            ),
                            checkmarkColor: Theme.of(context).primaryColor,
                            backgroundColor: const Color(0xFFE4E6EB),
                            selectedColor: const Color(0xFFDDEAFF),
                            selected: selectedSpecialityIndex == index,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedSpecialityIndex = index;
                              });
                            },
                            side: BorderSide.none,
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
                            dateController.clear();
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xFF0058C6), width: 1),
                        ),
                        child: const Text('Reset Filters'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 600,
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
