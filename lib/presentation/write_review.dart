import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_button.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({super.key});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  double _rating = 0.0;
  String _reviewText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Write Review'),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _starRating(),
              const SizedBox(
                height: 8,
              ),
              _textReview(),
              const SizedBox(
                height: 8,
              ),
              _saveButton(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _starRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _rating = 1.0;
            });
          },
          icon: Icon(
            _rating >= 1.0 ? Icons.star : Icons.star_border,
            size: 36,
            color: Colors.amber,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _rating = 2.0;
            });
          },
          icon: Icon(
            _rating >= 2.0 ? Icons.star : Icons.star_border,
            size: 36,
            color: Colors.amber,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _rating = 3.0;
            });
          },
          icon: Icon(
            _rating >= 3.0 ? Icons.star : Icons.star_border,
            size: 36,
            color: Colors.amber,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _rating = 4.0;
            });
          },
          icon: Icon(
            _rating >= 4.0 ? Icons.star : Icons.star_border,
            size: 36,
            color: Colors.amber,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _rating = 5.0;
            });
          },
          icon: Icon(
            _rating >= 5.0 ? Icons.star : Icons.star_border,
            size: 36,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  Widget _textReview() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Write your review here',
        border: OutlineInputBorder(),
      ),
      maxLines: 5,
      onChanged: (value) {
        setState(() {
          _reviewText = value;
        });
      },
    );
  }

  Widget _saveButton() {
    return CustomElevatedButton(
        text: 'Save',
        height: 44,
        radius: 8,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
