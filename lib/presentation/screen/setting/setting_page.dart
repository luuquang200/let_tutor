import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

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
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            Text('language'.tr(), style: CustomTextStyle.headlineMedium),
            const SizedBox(height: 8),
            RadioListTile<String>(
              title: Text('english'.tr()),
              value: 'en',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                setState(() {
                  _currentLanguage = value!;
                  context.setLocale(Locale(_currentLanguage, 'US'));
                });
              },
            ),
            RadioListTile<String>(
              title: Text('vietnamese'.tr()),
              value: 'vi',
              groupValue: _currentLanguage,
              onChanged: (String? value) {
                setState(() {
                  _currentLanguage = value!;
                  context.setLocale(Locale(_currentLanguage, 'VN'));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
