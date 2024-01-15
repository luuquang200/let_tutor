import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

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
