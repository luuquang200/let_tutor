import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_state.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/tutor_information_card.dart';
import 'package:number_paginator/number_paginator.dart';

import 'package:let_tutor/data/models/tutor.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({Key? key}) : super(key: key);

  @override
  TutorListPageState createState() => TutorListPageState();
}

class TutorListPageState extends State<TutorListPage> {
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
  final List<String> listNationalities = <String>[
    'Vietnamese',
    'Foreigner',
    'Tunisia'
  ];
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  bool isShowFilter = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpcomingLesson(),
              const SizedBox(
                height: 8,
              ),
              _buildHeaderRow(),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: isShowFilter,
                child: _inputFilter(context),
              ),
              // _inputFilter(context),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<TutorListBloc, TutorListState>(
                builder: (context, state) {
                  if (state is TutorListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TutorListSuccess) {
                    return _listTutorInformationCard(state.tutors);
                  } else if (state is TutorListFailure) {
                    return Text('Error: ${state.error}');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Recommended Tutors:', style: CustomTextStyle.headlineLarge),
        IconButton(
            onPressed: () {
              setState(() {
                isShowFilter = !isShowFilter;
              });
            },
            icon: const Icon(
              Icons.filter_list_outlined,
              size: 28,
            )),
      ],
    );
  }

  NumberPaginator _paginator() {
    return NumberPaginator(
      numberPages: 8,
      onPageChange: (index) {
        log(index.toString());
        setState(() {});
      },
    );
  }

  Widget _buildUpcomingLesson() {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 250,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Upcoming lesson',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sat, 28 Oct 23 02:30 - 02:55',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text("Enter lesson room"),
            icon: const Icon(Icons.play_circle_fill_outlined),
          ),
          const SizedBox(height: 20),
          const Text(
            'Total lesson time is 507 hours 5 minutes',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _selectNationality() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      ),
      isExpanded: true,
      value: listNationalities.first,
      items: listNationalities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/flags/$value.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? value) {},
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget _searchByName() {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.type_specimen_outlined),
        hintText: 'Enter a tutor name',
        hintStyle: TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }

  Widget _selectAvailableDate() {
    return TextField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        hintText: 'dd/MM/yyyy',
        hintStyle: TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
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
          dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        }
      },
    );
  }

  Widget _selectStartTime() {
    return TextField(
      controller: startTimeController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.access_time),
        hintText: 'Start time',
        hintStyle: TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          helpText: 'Select start time',
        );
        if (selectedTime != null && mounted) {
          startTimeController.text = selectedTime.format(context);
        }
      },
    );
  }

  Widget _selectEndTime() {
    return TextField(
      controller: endTimeController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.timelapse),
        hintText: 'End time',
        hintStyle: TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          helpText: 'Select end time',
        );
        if (selectedTime != null && mounted) {
          endTimeController.text = selectedTime.format(context);
        }
      },
    );
  }

  _specialitiesChips(BuildContext context) {
    return Wrap(
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
            // Add this line to dispatch the FilterTutorsBySpeciality event
            context
                .read<TutorListBloc>()
                .add(FilterTutorsBySpeciality(specialities[index]));
          },
          side: BorderSide.none,
        ),
      ),
    );
  }

  _buttonResetFilter() {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedSpecialityIndex = 0;
          dateController.clear();
        });
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF0058C6), width: 1),
      ),
      child: const Text('Reset Filters'),
    );
  }

  _listTutorInformationCard(List<Tutor> tutors) {
    // Sort tutors by favorite status and rating
    tutors.sort((a, b) {
      if (b.isFavorite != a.isFavorite) {
        return (b.isFavorite ?? false) ? 1 : -1;
      }
      return (b.rating ?? 0).compareTo(a.rating ?? 0);
    });

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tutors.length + 1, // Increase itemCount by 1
        itemBuilder: (context, index) {
          if (index < tutors.length) {
            return Column(
              children: [
                TutorInformationCard(tutor: tutors[index]),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return _paginator(); // Display _paginator at the end
          }
        },
      ),
    );
  }

  _inputFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Find a tutor',
              style: CustomTextStyle.headlineMedium,
            )),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _searchByName(),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: _selectNationality(),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('Select available tutoring time:',
              style: CustomTextStyle.headlineMedium),
        ),
        Row(
          children: [Expanded(child: _selectAvailableDate())],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _selectStartTime(),
            ),
            const SizedBox(width: 10),
            Expanded(child: _selectEndTime()),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Select speciality:', style: CustomTextStyle.headlineMedium),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _specialitiesChips(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buttonResetFilter(),
        ),
      ],
    );
  }
}