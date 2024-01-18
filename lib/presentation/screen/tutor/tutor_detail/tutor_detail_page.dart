import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_state.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/category.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_chip.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/icon_text_button.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:let_tutor/presentation/widgets/video_player.dart';
import 'package:let_tutor/routes.dart';

class TutorDetailPage extends StatefulWidget {
  final String tutorId;
  const TutorDetailPage({Key? key, required this.tutorId}) : super(key: key);

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  List<MyCategory> listLanguages = [];
  List<LearnTopic> listLearnTopics = [];
  List<TestPreparation> listTestPreparations = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutorDetailBloc, TutorDetailState>(
      listener: (context, state) {
        if (state is TutorDetailSuccess) {
          log('Load tutor detail page - listener');
          listLanguages = state.categories;
          listLearnTopics = state.learnTopics;
          listTestPreparations = state.testPreparations;

          if (state.reportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Report success !'),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state.updateFavoriteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                showCloseIcon: true,
                content: Text('Update favorite success !'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        BuildContext pContext = context;
        if (state is TutorDetailLoading) {
          return const Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TutorDetailSuccess) {
          log('load tutor detail page');
          Tutor tutor = state.tutor;
          return Scaffold(
            appBar: AppBar(
              title: Text('Tutor Detail', style: CustomTextStyle.topHeadline),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tutor Information
                  _tutorInformation(tutor),
                  const SizedBox(height: 16),
                  Text(tutor.bio ?? '', style: CustomTextStyle.bodyRegular),
                  const SizedBox(height: 16),

                  // Buttons: Favorite, Report and Review
                  _actionButtonsRow(context, pContext),

                  // Introduction Video
                  const SizedBox(height: 16),
                  MyVideoPlayer(url: tutor.video ?? ''),

                  // Education
                  const SizedBox(height: 16),
                  const Text('Education',
                      style: CustomTextStyle.headlineMedium),
                  const SizedBox(height: 8),
                  _education(tutor.education ?? ''),

                  // Languages
                  const SizedBox(height: 16),
                  const Text('Languages',
                      style: CustomTextStyle.headlineMedium),
                  const SizedBox(height: 8),
                  _language(tutor.languages),

                  // Specialities
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Specialities',
                      style: CustomTextStyle.headlineMedium),
                  const SizedBox(height: 8),
                  _specialities(tutor.specialties),

                  //Interests
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Interests',
                    style: CustomTextStyle.headlineMedium,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _interests(tutor)),

                  //Teaching experience
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Teaching Experience',
                    style: CustomTextStyle.headlineMedium,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _teachingExperience(tutor)),

                  // booking button
                  const SizedBox(
                    height: 16,
                  ),
                  _bookingButton(),
                ],
              ),
            ),
          );
        } else if (state is TutorDetailFailure) {
          return Text('Error: ${state.error}');
        } else {
          return Container();
        }
      },
    );
  }

  Widget _specialities(String? specialties) {
    if (specialties == null || specialties.isEmpty) {
      return Container();
    }

    List<String> specialtiesListCode = specialties.split(',');
    List<String> specialtiesList = getTutorSpecialties(specialtiesListCode);

    if (specialtiesList.isEmpty) {
      return const CustomChip(label: 'N/A');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: specialtiesList.map((specialty) {
        return CustomChip(label: specialty.trim());
      }).toList(),
    );
  }

  Widget _language(String? languages) {
    if (languages == null || languages.isEmpty) {
      return Container();
    }

    // get list language code
    List<String> codeLanguagesList = languages.split(',');

    // get list language name
    List<String> languagesList = [];
    for (String code in codeLanguagesList) {
      for (MyCategory language in listLanguages) {
        if (language.key == code) {
          languagesList.add(language.description ?? '');
          break;
        }
      }
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languagesList.map((language) {
        return CustomChip(label: language.trim());
      }).toList(),
    );
  }

  Row _actionButtonsRow(BuildContext context, BuildContext pContext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FavoriteButton(widget: widget),
        IconTextButton(
          icon: Icons.report_outlined,
          text: 'Report',
          color: Theme.of(context).primaryColor,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) =>
                  ReportDialog(tutorId: widget.tutorId, pContext: pContext),
            );
          },
        ),
        IconTextButton(
          icon: Icons.rate_review_outlined,
          text: 'Review',
          color: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.pushNamed(context, Routes.tutorReviewScreen,
                arguments: widget.tutorId);
          },
        ),
      ],
    );
  }

  _suggestedCourses() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const SizedBox(
              width: 10,
            ),
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

  _interests(Tutor tutor) {
    return Text(tutor.interests ?? '');
  }

  _teachingExperience(Tutor tutor) {
    return Text(tutor.experience ?? '');
  }

  _bookingButton() {
    return MyElevatedButton(
        text: 'Book this tutor',
        height: 50,
        radius: 8,
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.bookingScreen,
            arguments: widget.tutorId,
          );
        });
  }

  // void _showReportDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ReportDialog(tutorId: widget.tutorId),
  //   );
  // }

  String _getNameCountry(String codeOrName) {
    codeOrName = codeOrName.toUpperCase();
    final country = AppConfig.countries.firstWhere(
        (country) => country.code == codeOrName || country.name == codeOrName,
        orElse: () => Country(name: '', code: ''));
    return country.name;
  }

  Widget _tutorInformation(Tutor tutor) {
    String avatar = tutor.user?.avatar ?? '';
    String name = tutor.user?.name ?? '';
    String country = _getNameCountry(tutor.user?.country ?? '');
    return Row(
      children: [
        TutorAvatar(imageUrl: avatar, tutorName: name),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(name, style: CustomTextStyle.headlineLarge),
            Row(
              children: [
                // flag
                Flag(flagCode: tutor.user?.country ?? ''),
                const SizedBox(width: 10),
                Text(
                  country,
                  style: CustomTextStyle.bodyRegular,
                ),
              ],
            ),
            // Rating Star
            const SizedBox(height: 2),
            StarRating(rating: tutor.rating ?? 0, size: 20),
          ],
        )
      ],
    );
  }

  List<String> getTutorSpecialties(List<String> specialties) {
    List<String> specialtiesNames = [];

    for (String specialty in specialties) {
      for (LearnTopic topic in listLearnTopics) {
        if (topic.key == specialty) {
          specialtiesNames.add(topic.name ?? '');
          break;
        }
      }

      for (TestPreparation test in listTestPreparations) {
        if (test.key == specialty) {
          specialtiesNames.add(test.name ?? '');
          break;
        }
      }
    }

    return specialtiesNames;
  }

  _education(String education) {
    return Padding(
        padding: const EdgeInsets.only(left: 10), child: Text(education));
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.widget,
  });

  final TutorDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorDetailBloc, TutorDetailState>(
      builder: (context, state) {
        if (state is TutorDetailSuccess) {
          return IconTextButton(
            icon: state.tutor.isFavorite ?? false
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            text: 'Favorite',
            color: state.tutor.isFavorite ?? false
                ? Colors.red
                : Theme.of(context).primaryColor,
            onTap: () {
              context
                  .read<TutorDetailBloc>()
                  .add(FavouriteTutorEvent(tutorId: widget.tutorId));
            },
          );
        }
        return Container();
      },
    );
  }
}

class ReportDialog extends StatefulWidget {
  final String tutorId;
  final BuildContext pContext;
  const ReportDialog(
      {super.key, required this.tutorId, required this.pContext});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  Map<String, bool> reportReasons = {
    'This tutor is annoying me': false,
    'This profile is pretending to be someone or is fake': false,
    'Inappropriate profile photo': false,
  };
  TextEditingController textController = TextEditingController();

  void updateText(String text, bool isChecked) {
    if (isChecked) {
      textController.text = '${textController.text}$text\n';
    } else {
      textController.text = textController.text.replaceAll('$text\n', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning),
            SizedBox(width: 8),
            Text('Report Tutor'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Help us understand what's happening:",
                  style: CustomTextStyle.boldRegular),
              const SizedBox(height: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Help us understand what's happening:",
                      style: CustomTextStyle.boldRegular),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: reportReasons.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: reportReasons[key],
                        onChanged: (value) {
                          setState(() {
                            reportReasons[key] = value ?? false;
                          });
                          updateText(key, reportReasons[key]!);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Additional Information:',
                  style: CustomTextStyle.boldRegular),
              const SizedBox(height: 8),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Enter your report here',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          MyOutlineButton(
            text: 'Cancel',
            height: 25,
            radius: 5,
            onPressed: () => Navigator.pop(context),
            width: 26,
            textSize: 18,
          ),
          MyElevatedButton(
            text: 'Submit',
            height: 25,
            radius: 5,
            onPressed: () {
              widget.pContext.read<TutorDetailBloc>().add(ReportTutorEvent(
                  tutorId: widget.tutorId, content: textController.text));
              Navigator.pop(context);
            },
            width: 26,
            textSize: 18,
          )
        ],
      ),
    );
  }
}
