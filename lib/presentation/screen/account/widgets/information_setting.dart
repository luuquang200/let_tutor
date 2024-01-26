import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_bloc.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_event.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_state.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/presentation/screen/account/widgets/country_dropdown.dart';
import 'package:let_tutor/presentation/screen/account/widgets/level_dropdown.dart';
import 'package:let_tutor/presentation/screen/account/widgets/want_to_learn_select.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class InformationSetting extends StatelessWidget {
  InformationSetting({super.key});

  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final dateController = TextEditingController();
  final levelController = TextEditingController();
  final studyScheduleController = TextEditingController();
  late List<String> selectedLearnTopics;
  late List<String> selectedTestPreparations;
  late List<LearnTopic> learnTopics;
  late List<TestPreparation> testPreparations;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingBloc, ProfileSettingState>(
        bloc: BlocProvider.of<ProfileSettingBloc>(context),
        builder: (context, state) {
          if (state is ProfileSettingLoadSuccess) {
            nameController.text = state.user.name ?? '';
            countryController.text = state.user.country ?? '';
            dateController.text = state.user.birthday ?? '';
            levelController.text = state.user.level ?? '';
            selectedLearnTopics = state.selectedLearnTopics;
            selectedTestPreparations = state.selectedTestPreparations;
            learnTopics = state.learnTopics;
            testPreparations = state.testPreparations;
            studyScheduleController.text = state.user.studySchedule ?? '';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                requiredField('name'.tr()),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 50.0,
                  controller: nameController,
                  radius: 5,
                ),

                // email
                const SizedBox(height: 16),
                Text('Email'.tr(), style: CustomTextStyle.headlineMedium),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 50.0,
                  controller: TextEditingController(
                      text: state is ProfileSettingLoadSuccess
                          ? state.user.email
                          : ''),
                  radius: 3,
                  enableEdit: false,
                ),

                // country
                const SizedBox(height: 16),
                requiredField('country'.tr()),
                const SizedBox(height: 8),
                CountryDropdown(
                  initialValue: countryController.text,
                  onCountryChanged: (newCountry) {
                    countryController.text = newCountry;
                  },
                ),

                // phone
                const SizedBox(height: 16),
                requiredField('phone'.tr()),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 50.0,
                  controller: TextEditingController(
                      text: state is ProfileSettingLoadSuccess
                          ? state.user.phone
                          : ''),
                  radius: 3,
                  enableEdit: false,
                ),

                // Birthday
                const SizedBox(height: 16),
                requiredField('birthday'.tr()),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                  ),
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: dateController.text.isNotEmpty
                          ? DateFormat('yyyy-MM-dd').parse(dateController.text)
                          : DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                ),

                //level
                const SizedBox(height: 16),
                requiredField('level'.tr()),
                const SizedBox(height: 8),
                LevelDropdown(
                  initialValue: state is ProfileSettingLoadSuccess
                      ? state.user.level ?? ''
                      : '',
                  onLevelChanged: (newLevel) {
                    levelController.text = newLevel;
                  },
                ),

                // Want to learn
                const SizedBox(height: 16),
                requiredField('want_to_learn'.tr()),
                const SizedBox(height: 8),
                WantToLearnSelect(
                  selectedLearnTopics: selectedLearnTopics,
                  selectedTestPreparations: selectedTestPreparations,
                  learnTopics: learnTopics,
                  testPreparations: testPreparations,
                  onLearnTopicSelected: (String key) {
                    if (selectedLearnTopics.contains(key)) {
                      selectedLearnTopics.remove(key);
                    } else {
                      selectedLearnTopics.add(key);
                    }
                  },
                  onTestPreparationSelected: (String key) {
                    if (selectedTestPreparations.contains(key)) {
                      selectedTestPreparations.remove(key);
                    } else {
                      selectedTestPreparations.add(key);
                    }
                  },
                ),

                //Study Schedule
                const SizedBox(height: 16),
                Text('study_schedule'.tr(),
                    style: CustomTextStyle.headlineMedium),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 50.0,
                  controller: studyScheduleController,
                  radius: 3,
                ),

                // button save
                const SizedBox(height: 18),
                MyElevatedButton(
                  text: 'save'.tr(),
                  height: 50,
                  width: double.infinity,
                  radius: 6,
                  onPressed: () {
                    BlocProvider.of<ProfileSettingBloc>(context).add(
                      SaveProfileSetting(
                        name: nameController.text,
                        country: countryController.text,
                        birthday: dateController.text,
                        level: levelController.text,
                        studySchedule: studyScheduleController.text,
                        selectedLearnTopics: selectedLearnTopics,
                        selectedTestPreparations: selectedTestPreparations,
                      ),
                    );
                  },
                )
              ],
            ),
          );
        });
  }

  Widget requiredField(String text) {
    return Row(
      children: [
        const Text('*', style: TextStyle(color: Colors.red, fontSize: 18)),
        const SizedBox(width: 4),
        Text(text, style: CustomTextStyle.headlineMedium),
      ],
    );
  }
}
