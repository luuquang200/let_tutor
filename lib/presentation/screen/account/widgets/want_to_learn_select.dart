import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
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
