import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<IconData> icons = <IconData>[
    Icons.person_outline,
    Icons.account_balance_wallet_outlined,
    Icons.schedule_outlined,
    Icons.school_outlined,
    Icons.privacy_tip_outlined,
    Icons.lock_clock_outlined,
    Icons.help_center_outlined,
    Icons.logout_outlined,
  ];

  List<String> sections = <String>[
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            _avatar(),
            const SizedBox(height: 16),
            _name(),
            const SizedBox(height: 32),
            _itemList(),
          ],
        ),
      ),
    );
  }

  _avatar() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 198, 198), // Color of padding
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 98,
              backgroundImage: AssetImage('assets/account_avatar.jpeg'),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                width: 44,
                height: 41,
                padding: const EdgeInsets.all(1.0), // Adjust padding here
                decoration: const BoxDecoration(
                  color: Color(0xFF0058C6),
                  shape: BoxShape.circle, // Circular shape
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () {
                    // Handle editing action here
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _itemList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: _itemCard(context, index));
      },
    );
  }

  _name() {
    return Text('Adelia Rice',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }

  _itemCard(BuildContext context, int index) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icons[index],
              size: 30,
            ),
            const SizedBox(width: 12),
            Text(
              sections[index],
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
