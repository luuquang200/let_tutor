import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_event.dart';
import 'package:let_tutor/blocs/tutor/tutor_detail/tutor_detail_state.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_chip.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/icon_text_button.dart';
import 'package:let_tutor/presentation/widgets/specialities.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/video_player.dart';
import 'package:let_tutor/routes.dart';

class TutorDetailPage extends StatefulWidget {
  final String tutorId;
  const TutorDetailPage({Key? key, required this.tutorId}) : super(key: key);

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TutorDetailBloc, TutorDetailState>(
      listener: (context, state) {
        // Add listener code here
        if (state is TutorDetailSuccess) {
          log('load tutor detail page - listener');
        }
      },
      builder: (context, state) {
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
                  const SizedBox(
                    height: 16,
                  ),
                  Text(tutor.bio ?? '', style: CustomTextStyle.bodyRegular),
                  const SizedBox(
                    height: 16,
                  ),

                  // Buttons: Favorite, Report and Review
                  _actionButtonsRow(context),

                  // Introduction Video
                  const SizedBox(
                    height: 16,
                  ),
                  MyVideoPlayer(
                    url: tutor.video ?? '',
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
                  _language(tutor.language),

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
                  const Specialities(),

                  //Suggested courses
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Suggested Courses',
                    style: CustomTextStyle.headlineMedium,
                  ),
                  _suggestedCourses(),

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

// class _TutorDetailPageState extends State<TutorDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TutorDetailBloc, TutorDetailState>(
//       builder: (context, state) {
//         if (state is TutorDetailLoading) {
//           return const Center(
//             child: SizedBox(
//               height: 50.0,
//               width: 50.0,
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (state is TutorDetailSuccess) {
//           log('load tutor detail page');
//           final tutor = state.tutor;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Tutor Detail', style: CustomTextStyle.topHeadline),
//               iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Tutor Information
//                   _tutorInformation(tutor),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(tutor.bio ?? '', style: CustomTextStyle.bodyRegular),
//                   const SizedBox(
//                     height: 16,
//                   ),

//                   // Buttons: Favorite, Report and Review
//                   _actionButtonsRow(context),

//                   // Introduction Video
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   MyVideoPlayer(
//                     url: tutor.video ?? '',
//                   ),
//                   // Languages
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   const Text(
//                     'Languages',
//                     style: CustomTextStyle.headlineMedium,
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   _language(tutor.language),

//                   // Specialities
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   const Text(
//                     'Specialities',
//                     style: CustomTextStyle.headlineMedium,
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   const Specialities(),

//                   //Suggested courses
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   const Text(
//                     'Suggested Courses',
//                     style: CustomTextStyle.headlineMedium,
//                   ),
//                   _suggestedCourses(),

//                   //Interests
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     'Interests',
//                     style: CustomTextStyle.headlineMedium,
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: _interests(tutor)),

//                   //Teaching experience
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   const Text(
//                     'Teaching Experience',
//                     style: CustomTextStyle.headlineMedium,
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: _teachingExperience(tutor)),

//                   // booking button
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   _bookingButton(),
//                 ],
//               ),
//             ),
//           );
//         } else if (state is TutorDetailFailure) {
//           return Text('Error: ${state.error}');
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

  Widget _language(String? languages) {
    if (languages == null || languages.isEmpty) {
      return Container();
    }

    List<String> languagesList = languages.split(',');

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languagesList.map((language) {
        return CustomChip(
          label: language.trim(),
        );
      }).toList(),
    );
  }

  Row _actionButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FavoriteButton(widget: widget),
        IconTextButton(
          icon: Icons.report_outlined,
          text: 'Report',
          color: Theme.of(context).primaryColor,
          onTap: () {
            _showReportDialog();
          },
        ),
        IconTextButton(
          icon: Icons.rate_review_outlined,
          text: 'Review',
          color: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.pushNamed(context, Routes.tutorReviewScreen);
          },
        ),
      ],
    );
  }

  _suggestedCourses() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
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

  void _showReportDialog() {
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          title: const Text('This tutor is annoying me'),
                          value: false,
                          onChanged: (value) {
                            value = true;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text(
                              'This profile is pretending to be someone or is fake'),
                          value: false,
                          onChanged: (value) {
                            value = true;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Inappropriate profile photo'),
                          value: false,
                          onChanged: (value) {
                            value = true;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
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
                )),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ));
  }

  String _getNameCountry(String code) {
    final country = AppConfig.countries.firstWhere(
        (country) => country.code == code,
        orElse: () => Country(name: 'Unknown', code: 'Unknown'));
    return country.name;
  }

  _tutorInformation(Tutor tutor) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(tutor.avatar ?? ''),
          radius: 45,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(tutor.name ?? '', style: CustomTextStyle.headlineLarge),
            Row(
              children: [
                // flag
                // SvgPicture.network(
                //   AppConfig.getFlagUrl(tutor.country ?? ''),
                //   width: 20,
                //   height: 20,
                // ),

                const SizedBox(width: 10),
                Text(
                  _getNameCountry(tutor.country ?? ''),
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
