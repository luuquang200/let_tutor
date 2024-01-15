import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const ItemCard(
      {super.key,
      required this.text,
      required this.iconData,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 30,
              ),
              const SizedBox(width: 12),
              Text(
                text,
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
      ),
    );
  }
}
