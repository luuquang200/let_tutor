import 'package:flutter/material.dart';
import 'package:let_tutor/configs/app_config.dart';
import 'package:let_tutor/data/models/country.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

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
