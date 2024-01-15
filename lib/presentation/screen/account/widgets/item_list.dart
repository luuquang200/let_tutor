import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/account/widgets/item_card.dart';
import 'package:let_tutor/routes.dart';

class ItemList extends StatelessWidget {
  ItemList({super.key});

  final List<IconData> icons = <IconData>[
    Icons.person_outline,
    Icons.account_balance_wallet_outlined,
    Icons.schedule_outlined,
    Icons.school_outlined,
    Icons.privacy_tip_outlined,
    Icons.lock_clock_outlined,
    Icons.help_center_outlined,
    Icons.logout_outlined,
  ];

  final List<String> sections = <String>[
    'My profile',
    'My wallet',
    'Recurring Lesson Schedule',
    'Become a tutor',
    'Privacy Policy',
    'Change password',
    'Guide',
    'Log out'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ItemCard(
            text: sections[0],
            iconData: icons[0],
            onPressed: () {
              Navigator.pushNamed(context, Routes.profileSettingScreen);
            },
          ),
          ItemCard(
            text: sections[1],
            iconData: icons[1],
            onPressed: () {
              log('pressed 1');
            },
          ),
          ItemCard(
            text: sections[2],
            iconData: icons[2],
            onPressed: () {
              log('pressed 2');
            },
          ),
          ItemCard(
            text: sections[3],
            iconData: icons[3],
            onPressed: () {
              log('pressed 3');
            },
          ),
          ItemCard(
            text: sections[4],
            iconData: icons[4],
            onPressed: () {
              log('pressed 4');
            },
          ),
          ItemCard(
            text: sections[5],
            iconData: icons[5],
            onPressed: () {
              log('pressed 5');
            },
          ),
          ItemCard(
            text: sections[6],
            iconData: icons[6],
            onPressed: () {
              log('pressed 6');
            },
          ),
          ItemCard(
            text: sections[7],
            iconData: icons[7],
            onPressed: () {
              log('pressed 7');
            },
          ),
        ],
      ),
    );
  }
}
