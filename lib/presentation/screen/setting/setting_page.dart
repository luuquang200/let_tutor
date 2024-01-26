import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/level_filter.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:let_tutor/presentation/styles/theme.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    _currentLanguage = context.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr(), style: CustomTextStyle.topHeadline),
        iconTheme: AppTheme.iconTheme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme
            _sectionTitle('theme'.tr()),
            SwitchListTile(
              title: Text('dark_mode'.tr()),
              value: AppTheme.isLightTheme,
              onChanged: (bool value) {
                Provider.of<AppTheme>(context, listen: false).toggleTheme();
                setState(() {});
              },
            ),

            // Language
            const SizedBox(height: 16),
            _sectionTitle('language'.tr()),
            const SizedBox(height: 8),
            RadioListTile<String>(
              title: Text('english'.tr()),
              value: 'en',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                _currentLanguage = value!;
                context.setLocale(Locale(_currentLanguage, 'US'));
              },
            ),
            RadioListTile<String>(
              title: Text('vietnamese'.tr()),
              value: 'vi',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                _currentLanguage = value!;
                context.setLocale(Locale(_currentLanguage, 'VN'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String sectionTitle) {
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
}
