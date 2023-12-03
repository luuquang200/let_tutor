import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/data/models/tutor.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/routes.dart';

class TutorInformationCard extends StatelessWidget {
  final Tutor tutor;
  const TutorInformationCard({Key? key, required this.tutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.tutorDetail,
            arguments: tutor.id,
          );
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
              // Avatar
              // CircleAvatar(
              //   backgroundImage: NetworkImage(tutor.avatar ?? ''),
              //   radius: 44,
              // ),
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(tutor.avatar ?? ''),
              ),
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
                      SvgPicture.asset(
                        'assets/flags/Foreigner.svg',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        tutor.country ?? '',
                        style: CustomTextStyle.bodyRegular,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // row
                  buildStarRating(tutor.rating?.toInt() ?? 0, 20)
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
          (tutor.isFavorite ?? false)
              ? Icons.favorite
              : Icons.favorite_border_outlined,
          color: (tutor.isFavorite ?? false)
              ? Colors.red
              : const Color(0xFF0058C6),
        ),
      ),
    );
  }

  Widget buildStarRating(int rating, double size) {
    return Row(
      children: List<Widget>.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: index < rating ? Colors.amber : Colors.grey,
          size: size,
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
      spacing: 8,
      runSpacing: 8,
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
