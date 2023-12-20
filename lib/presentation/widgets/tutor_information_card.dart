import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_bloc.dart';
import 'package:let_tutor/blocs/tutor/tutor_list/tutor_list_event.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/widgets/flag.dart';
import 'package:let_tutor/presentation/widgets/star_rating.dart';
import 'package:let_tutor/presentation/widgets/tutor_avatar.dart';
import 'package:let_tutor/routes.dart';

class TutorInformationCard extends StatelessWidget {
  final Tutor tutor;
  const TutorInformationCard({Key? key, required this.tutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          final bloc = context.read<TutorListBloc>();
          await Navigator.pushNamed(
            context,
            Routes.tutorDetail,
            arguments: tutor.id,
          );
          bloc.add(TutorListRequested());
        },
        child: Card(
          elevation: 5,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              _favoriteButton(tutor),
              // Column
              _tutorInformation(tutor),
              // Book button
              _bookButton()
            ],
          ),
        ));
  }

  Padding _tutorInformation(Tutor tutor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TutorAvatar(imageUrl: tutor.avatar!, tutorName: tutor.name!),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    tutor.name ?? '',
                    style: CustomTextStyle.headlineLarge,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // flag
                      Flag(flagCode: tutor.country ?? ''),
                      const SizedBox(width: 10),
                      Text(
                        _getNameCountry(tutor.country ?? ''),
                        style: CustomTextStyle.bodyRegular,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // row
                  StarRating(rating: tutor.rating ?? 0, size: 20),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Specialities",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          buildSpecialtiesChips(tutor.specialties),
          const SizedBox(
            height: 10,
          ),
          Text(tutor.bio ?? ''),
          const SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }

  String _getNameCountry(String codeOrName) {
    final country = AppConfig.countries.firstWhere(
        (country) => country.code == codeOrName || country.name == codeOrName,
        orElse: () => Country(name: '', code: ''));
    return country.name;
  }

  Positioned _bookButton() {
    return Positioned(
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
        ));
  }

  Positioned _favoriteButton(Tutor tutor) {
    return Positioned(
      top: 10,
      right: 10,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          (tutor.isFavoriteTutor ?? false)
              ? Icons.favorite
              : Icons.favorite_border_outlined,
          color: (tutor.isFavoriteTutor ?? false)
              ? Colors.red
              : const Color(0xFF0058C6),
        ),
      ),
    );
  }

  Widget buildSpecialtiesChips(String? specialties) {
    if (specialties == null || specialties.isEmpty) {
      return Container();
    }

    List<String> specialtiesList = specialties.split(',');

    return Wrap(
      spacing: 5,
      runSpacing: 2,
      children: specialtiesList.map((specialty) {
        return Chip(
          backgroundColor: const Color(0xFFDDEAFF),
          side: BorderSide.none,
          label: Text(
            specialty,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0058C6)),
          ),
        );
      }).toList(),
    );
  }
}

String getInitials(String name) {
  List<String> names = name.split(" ");
  String initials = "";
  int numWords = 2;

  if (numWords < names.length) {
    numWords = names.length;
  }

  for (var i = 0; i < numWords; i++) {
    initials += names[i][0];
  }

  return initials;
}
