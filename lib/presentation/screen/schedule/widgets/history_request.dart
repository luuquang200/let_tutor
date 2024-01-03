import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/styles/custom_text_style.dart';

class HistoryRequest extends StatefulWidget {
  const HistoryRequest({super.key, this.request});
  final String? request;
  @override
  State<HistoryRequest> createState() => _HistoryRequestState();
}

class _HistoryRequestState extends State<HistoryRequest> {
  bool isRequestExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.request_page_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Row(
                    children: [
                      Text('Requests for lesson:',
                          style: CustomTextStyle.bodyRegular),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isRequestExpanded = !isRequestExpanded;
                      });
                    },
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isRequestExpanded
                          ? Icons.arrow_drop_down_sharp
                          : Icons.arrow_right_sharp,
                      size: 38,
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ),
            Visibility(
                visible: isRequestExpanded,
                child: Padding(
                    padding: const EdgeInsets.only(left: 28, right: 8),
                    child: Text(widget.request ?? 'No request for lesson')))
          ],
        ));
  }
}
