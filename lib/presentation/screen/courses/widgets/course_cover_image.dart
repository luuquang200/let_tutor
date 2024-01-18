import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/screen/courses/widgets/loading_indicator.dart';

class CourseCoverImage extends StatelessWidget {
  final String imageUrl;
  final double width;

  const CourseCoverImage({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FutureBuilder<String?>(
        future: checkUrl(imageUrl),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('No image'));
          } else {
            return CachedNetworkImage(
              imageUrl: snapshot.data!,
              progressIndicatorBuilder: (context, url, progress) => Center(
                widthFactor: 1,
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            );
          }
        },
      ),
    );
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
        log('statusCode: ${response.statusCode}');
        return null;
      }
      return url;
    } catch (e) {
      return null;
    }
  }
}
