import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:let_tutor/data/models/course/topic.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';
import 'package:path_provider/path_provider.dart';

class TopicDetail extends StatefulWidget {
  const TopicDetail({super.key, required this.topic});
  final Topic topic;

  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  String localPath = '';
  int? currentPage = 0;
  int? totalPages = 0;
  PDFViewController? pdfViewController;

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {
    var dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    var path = '${dir.path}/topic.pdf';

    await dio.download(widget.topic.nameFile ?? '', path);

    setState(() {
      localPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Topic Detail', style: CustomTextStyle.topHeadline),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${widget.topic.orderCourse! + 1}. ${widget.topic.name ?? ''}',
                  style: CustomTextStyle.headlineMedium),
              const SizedBox(height: 12),
              // PDF Viewer
              Expanded(
                child: localPath != ''
                    ? PDFView(
                        enableSwipe: true,
                        autoSpacing: false,
                        pageFling: false,
                        filePath: localPath,
                        onPageChanged: (page, total) {
                          setState(() {
                            currentPage = page;
                            totalPages = total;
                          });
                        },
                        onViewCreated: (PDFViewController pdfViewController) {
                          setState(() {
                            this.pdfViewController = pdfViewController;
                          });
                        })
                    : const Center(child: CircularProgressIndicator()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (pdfViewController != null) {
                          pdfViewController!.setPage(currentPage! - 1);
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const SizedBox(width: 10),
                  Text('Page ${currentPage! + 1} / $totalPages',
                      style: CustomTextStyle.bodyRegular),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        if (pdfViewController != null) {
                          pdfViewController!.setPage(currentPage! + 1);
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              ),
            ],
          ),
        ));
  }
}
