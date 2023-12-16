import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class TutorAvatar extends StatelessWidget {
  final String imageUrl;
  final String tutorName;

  const TutorAvatar(
      {super.key, required this.imageUrl, required this.tutorName});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 46,
      backgroundColor: Colors.grey,
      child: FutureBuilder<String?>(
        future: checkUrl(imageUrl),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return CircleAvatar(
              radius: 44,
              child: Text(
                getInitials(tutorName),
                style: CustomTextStyle.initialNameOfTutor,
              ),
            );
          } else {
            return CachedNetworkImage(
              imageUrl: snapshot.data!,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 44,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 44,
                child: Text(
                  getInitials(tutorName),
                  style: CustomTextStyle.initialNameOfTutor,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }

    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }

    log('initials: $initials');
    return initials;
  }

  Future<String?> checkUrl(String url) async {
    try {
      final response = await Dio().head(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status != null ? status < 500 : false;
          },
        ),
      );
      if (response.statusCode != 200) {
        return null;
      }
      return url;
    } catch (e) {
      return null;
    }
  }
}
