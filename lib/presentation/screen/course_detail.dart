import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/screen/tutor_detail.dart';
import 'package:let_tutor/routes.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<String> listOfTopics = [
    'The Internet',
    'Artificial Intelligence (AI)',
    'Social Media',
    'Internet Privacy',
    'Live Streaming',
    'Coding',
    'Technology Transforming Healthcare',
    'Smart Home Technology',
    'Remote Work - A Dream Job?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Course Detail', style: CustomTextStyle.topHeadline),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
      body: SingleChildScrollView(
        child: Column(children: [
          // Course cover photo
          Image.asset('assets/course_img_url.png'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _introductionInfo(),
                const SizedBox(height: 12),
                _dicoveryButton(),
                const SizedBox(height: 12),
                _sectionTitle(context, 'Overview'),
                _courseOverview(),
                const SizedBox(height: 12),
                _sectionTitle(context, 'Experience Level'),
                _expereinceLevel(),
                const SizedBox(height: 12),
                _sectionTitle(context, 'Course Length'),
                _courseLength(),
                const SizedBox(height: 12),
                _sectionTitle(context, 'List Of Topics'),
                _topicsList(),
                _sectionTitle(context, 'Suggested Tutors'),
                _suggestTutors(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _dicoveryButton() {
    return MyElevatedButton(
      text: 'Discover',
      height: 50,
      radius: 8,
      onPressed: () {},
    );
  }

  Widget _sectionTitle(BuildContext context, String sectionTitle) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
          child: Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(sectionTitle, style: CustomTextStyle.headlineLarge),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
          child: Divider(height: 1, color: Color.fromARGB(255, 200, 197, 197)),
        )
      ],
    );
  }

  _courseOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.help_outline, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'Why Take This Course?',
              style: CustomTextStyle.headlineMedium,
            ),
          ],
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 32, right: 16),
          child: Text(
            "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.help_outline, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'What will you be able to do?',
              style: CustomTextStyle.headlineMedium,
            ),
          ],
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 32, right: 16),
          child: Text(
            "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
          ),
        ),
      ],
    );
  }

  _expereinceLevel() {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.group_add_outlined, color: Color(0xFF0058C6)),
              SizedBox(width: 8),
              Text('Intermediate', style: CustomTextStyle.headlineMedium),
            ],
          )
        ]);
  }

  _courseLength() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.book_outlined, color: Color(0xFF0058C6)),
            SizedBox(width: 8),
            Text('9 Topics', style: CustomTextStyle.headlineMedium),
          ],
        )
      ],
    );
  }

  _topicsList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOfTopics.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Routes.navigateTo(context, Routes.topicDetail);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Card(
                elevation: 1.5,
                surfaceTintColor: Colors.white,
                child: ListTile(
                    title: Text('${index + 1}. ${listOfTopics[index]}'))),
          ),
        );
      },
    );
  }

  _suggestTutors() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        children: [
          Text('Adelia Rice', style: CustomTextStyle.headlineMedium),
          const SizedBox(width: 16),
          TextButton(
              onPressed: () {
                Routes.navigateTo(context, Routes.tutorDetail);
              },
              child: const Text('More Info')),
        ],
      ),
    );
  }

  _introductionInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Life in the Internet Age', style: CustomTextStyle.titleLarge),
        SizedBox(height: 12),
        Text(
          "Let's discuss how technology is changing the way we live",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
