import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_bloc.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_event.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_state.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/custom_snack_bar.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  List<IconData> icons = <IconData>[
    Icons.person_outline,
    Icons.account_balance_wallet_outlined,
    Icons.schedule_outlined,
    Icons.school_outlined,
    Icons.privacy_tip_outlined,
    Icons.lock_clock_outlined,
    Icons.help_center_outlined,
    Icons.logout_outlined,
  ];

  List<String> sections = <String>[
    'My profile',
    'My wallet',
    'Recurring Lesson Schedule',
    'Become a tutor',
    'Privacy Policy',
    'Change password',
    'Guide',
    'Log out'
  ];

  User user = User();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSettingBloc(
        userRepository: UserRepository(),
        tutorRepository: TutorRepository(),
      )..add(const GetProfileSettingPage()),
      child: BlocConsumer<ProfileSettingBloc, ProfileSettingState>(
        listener: (context, state) {
          if (state is ProfileSettingLoadSuccess) {
            if (state.isInvalidChange) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  icon: Icons.error,
                  backgroundColor: Colors.red,
                ),
              );
            }

            user = state.user;
            if (state.isUpdatedSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: 'Updated successfully',
                  icon: Icons.check,
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is ProfileSettingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSettingLoadSuccess) {
            user = state.user;
            return Scaffold(
              appBar: AppBar(
                title: Text('Profile', style: CustomTextStyle.topHeadline),
                iconTheme:
                    const IconThemeData(color: Color.fromARGB(255, 0, 88, 198)),
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    _avatar(user, context),
                    const SizedBox(height: 16),
                    InformationSetting()
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load account information'),
            );
          }
        },
      ),
    );
  }

  _avatar(User user, BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 198, 198), // Color of padding
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            TutorAvatar(
              imageUrl: user.avatar ?? '',
              tutorName: user.name ?? '',
              radius: 98,
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                width: 44,
                height: 41,
                padding: const EdgeInsets.all(1.0), // Adjust padding here
                decoration: const BoxDecoration(
                  color: Color(0xFF0058C6),
                  shape: BoxShape.circle, // Circular shape
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () async {
                    // choose image to change avatar
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      BlocProvider.of<ProfileSettingBloc>(context).add(
                        ChangeAvatar(
                          avatarUrl: pickedFile.path,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _name(User user) {
    return Text(user.name ?? '',
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }
}

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
                requiredField('Name'),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 50.0,
                  controller: nameController,
                  radius: 5,
                ),

                // email
                const SizedBox(height: 16),
                const Text('Email', style: CustomTextStyle.headlineMedium),
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
                requiredField('Country'),
                const SizedBox(height: 8),
                CountryDropdown(
                  initialValue: countryController.text,
                  onCountryChanged: (newCountry) {
                    countryController.text = newCountry;
                  },
                ),

                // phone
                const SizedBox(height: 16),
                requiredField('Phone'),
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
                requiredField('Birthday'),
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
                requiredField('Level'),
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
                requiredField('Want to learn'),
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
                const Text('Study Schedule',
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
                  text: 'Save',
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

class CustomTextField extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final double radius;
  final bool enableEdit;

  const CustomTextField({
    Key? key,
    required this.height,
    required this.controller,
    required this.radius,
    this.enableEdit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        controller: controller,
        enabled: enableEdit,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

class CountryDropdown extends StatefulWidget {
  final String initialValue;
  final double height;
  final double radius;
  final ValueChanged<String> onCountryChanged;

  const CountryDropdown({
    Key? key,
    required this.initialValue,
    this.height = 50.0,
    this.radius = 5.0,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  late String currentCountry;

  @override
  void initState() {
    super.initState();
    currentCountry = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        isExpanded: true,
        value: currentCountry,
        items: AppConfig.countries.map((Country country) {
          return DropdownMenuItem<String>(
            value: country.code,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(country.name, style: CustomTextStyle.bodyRegular),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            currentCountry = newValue!;
          });
          widget.onCountryChanged(currentCountry);
        },
      ),
    );
  }
}

class LevelDropdown extends StatefulWidget {
  final String initialValue;
  final double height;
  final double radius;
  final ValueChanged<String> onLevelChanged;

  const LevelDropdown({
    Key? key,
    required this.initialValue,
    this.height = 50.0,
    this.radius = 5.0,
    required this.onLevelChanged,
  }) : super(key: key);

  @override
  State<LevelDropdown> createState() => _LevelDropdownState();
}

class _LevelDropdownState extends State<LevelDropdown> {
  late String currentLevel;
  static List<String> levels = [
    'BEGINNER',
    'HIGHER_BEGINNER',
    'PRE_INTERMEDIATE',
    'INTERMEDIATE',
    'UPPER_INTERMEDIATE',
    'ADVANCED',
    'PROFICIENCY',
  ];

  @override
  void initState() {
    super.initState();
    currentLevel = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        isExpanded: true,
        value: currentLevel,
        items: levels.map((String level) {
          return DropdownMenuItem<String>(
            value: level,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(level, style: CustomTextStyle.bodyRegular),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            currentLevel = newValue!;
          });
          widget.onLevelChanged(currentLevel);
        },
      ),
    );
  }
}

class WantToLearnSelect extends StatefulWidget {
  final List<String> selectedLearnTopics;
  final List<String> selectedTestPreparations;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final ValueChanged<String> onLearnTopicSelected;
  final ValueChanged<String> onTestPreparationSelected;

  const WantToLearnSelect({
    super.key,
    required this.selectedLearnTopics,
    required this.selectedTestPreparations,
    required this.learnTopics,
    required this.testPreparations,
    required this.onLearnTopicSelected,
    required this.onTestPreparationSelected,
  });

  @override
  State<WantToLearnSelect> createState() => _WantToLearnSelectState();
}

class _WantToLearnSelectState extends State<WantToLearnSelect> {
  late List<bool> isSelectedLearnTopics;
  late List<bool> isSelectedTestPreparations;

  @override
  void initState() {
    super.initState();
    isSelectedLearnTopics = widget.learnTopics
        .map(
            (topic) => widget.selectedLearnTopics.contains(topic.id.toString()))
        .toList();
    isSelectedTestPreparations = widget.testPreparations
        .map((test) =>
            widget.selectedTestPreparations.contains(test.id.toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.learnTopics.map((topic) {
            int index = widget.learnTopics.indexOf(topic);
            return FilterChip(
              label: Text(
                topic.name!,
                style: TextStyle(
                    color: isSelectedLearnTopics[index]
                        ? Theme.of(context).primaryColor
                        : Colors.black54),
              ),
              selected: isSelectedLearnTopics[index],
              checkmarkColor: Theme.of(context).primaryColor,
              backgroundColor: const Color(0xFFE4E6EB),
              selectedColor: const Color(0xFFDDEAFF),
              onSelected: (bool selected) {
                setState(() {
                  isSelectedLearnTopics[index] = selected;
                });
                widget.onLearnTopicSelected(topic.id.toString());
              },
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.testPreparations.map((test) {
            int index = widget.testPreparations.indexOf(test);
            return FilterChip(
              label: Text(
                test.name!,
                style: TextStyle(
                    color: isSelectedTestPreparations[index]
                        ? Theme.of(context).primaryColor
                        : Colors.black54),
              ),
              selected: isSelectedTestPreparations[index],
              checkmarkColor: Theme.of(context).primaryColor,
              backgroundColor: const Color(0xFFE4E6EB),
              selectedColor: const Color(0xFFDDEAFF),
              onSelected: (bool selected) {
                setState(() {
                  isSelectedTestPreparations[index] = selected;
                });
                widget.onTestPreparationSelected(test.id.toString());
              },
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }
}
