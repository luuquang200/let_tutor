// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:let_tutor/presentation/styles/custom_button.dart';
// import 'package:let_tutor/presentation/styles/custom_chip.dart';
// import 'package:let_tutor/presentation/styles/custom_text_style.dart';
// import 'package:let_tutor/presentation/widgets/icon_text_button.dart';
// import 'package:let_tutor/presentation/widgets/specialities.dart';
// import 'package:let_tutor/routes.dart';

// class TutorDetailPage extends StatefulWidget {
//   const TutorDetailPage({Key? key}) : super(key: key);

//   @override
//   State<TutorDetailPage> createState() => _TutorDetailPageState();
// }

// class _TutorDetailPageState extends State<TutorDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Tutor Detail', style: CustomTextStyle.topHeadline),
//           iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Tutor Information
//             _tutorInformation(),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//                 'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.'),
//             const SizedBox(
//               height: 16,
//             ),

//             // Buttons: Favorite, Report and Review
//             _actionButtonsRow(context),

//             // Introduction Video
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               height: 200,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               child: const Text(
//                 'Introduction Video',
//                 style: CustomTextStyle.headlineMedium,
//               ),
//             ),

//             // Languages
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Languages',
//               style: CustomTextStyle.headlineMedium,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             const CustomChip(
//               label: "English",
//             ),

//             // Specialities
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Specialities',
//               style: CustomTextStyle.headlineMedium,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             const Specialities(),

//             //Suggested courses
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Suggested Courses',
//               style: CustomTextStyle.headlineMedium,
//             ),
//             _suggestedCourses(),

//             //Interests
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Interests',
//               style: CustomTextStyle.headlineMedium,
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(left: 10), child: _interests()),

//             //Teaching experience
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Teaching Experience',
//               style: CustomTextStyle.headlineMedium,
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: _teachingExperience()),

//             // booking button
//             const SizedBox(
//               height: 16,
//             ),
//             _bookingButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Row _actionButtonsRow(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconTextButton(
//           icon: Icons.favorite_outline,
//           text: 'Favorite',
//           color: Theme.of(context).primaryColor,
//           onTap: () {},
//         ),
//         IconTextButton(
//           icon: Icons.report_outlined,
//           text: 'Report',
//           color: Theme.of(context).primaryColor,
//           onTap: () {
//             _showReportDialog();
//           },
//         ),
//         IconTextButton(
//           icon: Icons.rate_review_outlined,
//           text: 'Review',
//           color: Theme.of(context).primaryColor,
//           onTap: () {
//             Navigator.pushNamed(context, Routes.tutorReviewScreen);
//           },
//         ),
//       ],
//     );
//   }

//   _suggestedCourses() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: 1,
//       itemBuilder: (context, index) {
//         return Row(
//           children: [
//             const SizedBox(
//               width: 10,
//             ),
//             const Text(
//               'Life in the Internet Age:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text('Link'),
//             )
//           ],
//         );
//       },
//     );
//   }

//   _interests() {
//     return const Text(
//         'I loved the weather, the scenery and the laid-back lifestyle of the locals.');
//   }

//   _teachingExperience() {
//     return const Text(
//         'I have more than 10 years of teaching english experience');
//   }

//   _bookingButton() {
//     return MyElevatedButton(
//         text: 'Book this tutor',
//         height: 50,
//         radius: 8,
//         onPressed: () {
//           Navigator.pushNamed(context, Routes.bookingScreen);
//         });
//   }

//   void _showReportDialog() {
//     final textController = TextEditingController();
//     showDialog(
//         context: context,
//         builder: (context) => SingleChildScrollView(
//               child: AlertDialog(
//                 title: const Row(
//                   children: [
//                     Icon(Icons.warning),
//                     SizedBox(width: 8),
//                     Text('Report Tutor'),
//                   ],
//                 ),
//                 content: SingleChildScrollView(
//                     child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Help us understand what's happening:",
//                         style: CustomTextStyle.boldRegular),
//                     const SizedBox(height: 8),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CheckboxListTile(
//                           title: const Text('This tutor is annoying me'),
//                           value: false,
//                           onChanged: (value) {
//                             value = true;
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),
//                         CheckboxListTile(
//                           title: const Text(
//                               'This profile is pretending to be someone or is fake'),
//                           value: false,
//                           onChanged: (value) {
//                             value = true;
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),
//                         CheckboxListTile(
//                           title: const Text('Inappropriate profile photo'),
//                           value: false,
//                           onChanged: (value) {
//                             value = true;
//                           },
//                           controlAffinity: ListTileControlAffinity.leading,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     const Text('Additional Information:',
//                         style: CustomTextStyle.boldRegular),
//                     const SizedBox(height: 8),
//                     TextField(
//                       controller: textController,
//                       decoration: const InputDecoration(
//                         hintText: 'Enter your report here',
//                         border: OutlineInputBorder(),
//                       ),
//                       maxLines: 5,
//                     ),
//                   ],
//                 )),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Cancel',
//                         style: TextStyle(color: Colors.red)),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ],
//               ),
//             ));
//   }

//   _tutorInformation() {
//     return Row(
//       children: [
//         const CircleAvatar(
//           radius: 45,
//           backgroundImage: AssetImage('assets/tutor_avatar.jpg'),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Name
//             const Text("Adelia Rice", style: CustomTextStyle.headlineLarge),
//             Row(
//               children: [
//                 SvgPicture.asset(
//                   'assets/flags/Foreigner.svg',
//                   width: 20,
//                   height: 20,
//                 ),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'United States',
//                   style: CustomTextStyle.bodyRegular,
//                 ),
//               ],
//             ),
//             // row
//             Row(
//                 children: List<Widget>.generate(
//               5,
//               (index) => const Icon(Icons.star, color: Colors.amber),
//             ))
//           ],
//         )
//       ],
//     );
//   }
// }
