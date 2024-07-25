import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/response_container.dart';

// ignore: must_be_immutable
class MultipleResponseWidget extends StatefulWidget {
  MultipleResponseWidget({
    super.key,
    required this.responseSelectedIndex,
    required this.answers,
    required this.onResponseSelected,
    required this.update,
  });
  int responseSelectedIndex;
  final List<dynamic> answers;
  final void Function(int) update;
  final Function(String?) onResponseSelected;

  @override
  State<MultipleResponseWidget> createState() => _MultipleResponseWidgetState();
}

class _MultipleResponseWidgetState extends State<MultipleResponseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.responseSelectedIndex == 0) {
                // Deselect the currently selected response
                widget.responseSelectedIndex = -1;
                widget.update(-1);
                widget.onResponseSelected(null);
              } else {
                // Select the tapped response
                widget.responseSelectedIndex = 0;
                widget.update(0);
                widget.onResponseSelected(widget.answers[0]);
              }
            });
          },
          child: ResponseContainer(
            response: widget.answers[0]
                .replaceAll("&#039;", "'")
                .replaceAll("&quot;", '"')
                .replaceAll("&amp;", "&")
                .replaceAll("&ldquo;", '"')
                .replaceAll("&rdquo;", '"')
                .replaceAll("&lsquo;", "'")
                .replaceAll("&rsquo;", "'"),
            order: "A",
            color: widget.responseSelectedIndex == 0
                ? const Color(0xffb2d8d8)
                : Colors.transparent,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.responseSelectedIndex == 1) {
                // Deselect the currently selected response
                widget.responseSelectedIndex = -1;
                widget.update(-1);
                widget.onResponseSelected(null);
              } else {
                // Select the tapped response
                widget.responseSelectedIndex = 1;
                widget.update(1);
                widget.onResponseSelected(widget.answers[1]);
              }
            });
          },
          child: ResponseContainer(
            response: widget.answers[1]
                .replaceAll("&#039;", "'")
                .replaceAll("&quot;", '"')
                .replaceAll("&amp;", "&")
                .replaceAll("&ldquo;", '"')
                .replaceAll("&rdquo;", '"')
                .replaceAll("&lsquo;", "'")
                .replaceAll("&rsquo;", "'"),
            order: "B",
            color: widget.responseSelectedIndex == 1
                ? const Color(0xffb2d8d8)
                : Colors.transparent,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.responseSelectedIndex == 2) {
                // Deselect the currently selected response
                widget.responseSelectedIndex = -1;
                widget.update(-1);
                widget.onResponseSelected(null);
              } else {
                // Select the tapped response
                widget.responseSelectedIndex = 2;
                widget.update(2);
                widget.onResponseSelected(widget.answers[2]);
              }
            });
          },
          child: ResponseContainer(
            response: widget.answers[2]
                .replaceAll("&#039;", "'")
                .replaceAll("&quot;", '"')
                .replaceAll("&amp;", "&")
                .replaceAll("&ldquo;", '"')
                .replaceAll("&rdquo;", '"')
                .replaceAll("&lsquo;", "'")
                .replaceAll("&rsquo;", "'"),
            order: "C",
            color: widget.responseSelectedIndex == 2
                ? const Color(0xffb2d8d8)
                : Colors.transparent,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.responseSelectedIndex == 3) {
                // Deselect the currently selected response
                widget.responseSelectedIndex = -1;
                widget.update(-1);
                widget.onResponseSelected(null);
              } else {
                // Select the tapped response
                widget.responseSelectedIndex = 3;
                widget.update(3);
                widget.onResponseSelected(widget.answers[3]);
              }
            });
          },
          child: ResponseContainer(
            response: widget.answers[3]
                .replaceAll("&#039;", "'")
                .replaceAll("&quot;", '"')
                .replaceAll("&amp;", "&")
                .replaceAll("&ldquo;", '"')
                .replaceAll("&rdquo;", '"')
                .replaceAll("&lsquo;", "'")
                .replaceAll("&rsquo;", "'"),
            order: "D",
            color: widget.responseSelectedIndex == 3
                ? const Color(0xffb2d8d8)
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
