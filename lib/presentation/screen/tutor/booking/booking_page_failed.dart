import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class BookingPageFailed extends StatelessWidget {
  final String error;

  const BookingPageFailed({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking', style: CustomTextStyle.topHeadline),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.blur_linear_outlined, size: 100),
            Text(error, style: CustomTextStyle.headlineLarge),
          ],
        ),
      ),
    );
  }
}
