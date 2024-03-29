import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/account/account_home/account_bloc.dart';
import 'package:let_tutor/blocs/account/account_home/account_event.dart';
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
    Icons.settings_outlined,
    Icons.logout_outlined,
  ];

  final List<String> sections = <String>[
    'my_profile'.tr(),
    'my_wallet'.tr(),
    'recurring_lesson_schedule'.tr(),
    'become_a_tutor'.tr(),
    'privacy_policy'.tr(),
    'change_password'.tr(),
    'settings'.tr(),
    'log_out'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AccountBloc>(context),
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final accountBloc = BlocProvider.of<AccountBloc>(context);
            return ItemCard(
              iconData: icons[index],
              text: sections[index],
              onPressed: () async {
                switch (index) {
                  case 0:
                    await Routes.navigateTo(
                        context, Routes.profileSettingScreen);
                    accountBloc.add(const GetAccountPage());
                    break;
                  case 1:
                    log('pressed 1');
                    break;
                  case 2:
                    log('pressed 2');
                    break;
                  case 3:
                    log('pressed 3');
                    break;
                  case 4:
                    log('pressed 4');
                    break;
                  case 5:
                    log('pressed 5');
                    break;
                  case 6:
                    await Routes.navigateTo(context, Routes.settingsPage);
                    accountBloc.add(const GetAccountPage());
                    break;
                  case 7:
                    BlocProvider.of<AccountBloc>(context).add(const Logout());
                    break;
                  default:
                    break;
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 1,
            );
          },
        );
      },
    );
  }
}
