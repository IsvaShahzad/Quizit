import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/response_container.dart';

// ignore: must_be_immutable
class MultipleCorrectionWidget extends StatefulWidget {
  MultipleCorrectionWidget({
    super.key,
    required this.responseSelectedIndex,
    required this.answers,
    required this.onResponseSelected,
    required this.wrongAnswers,
  });
  int responseSelectedIndex;
  final List<dynamic> answers;
  final List<dynamic> wrongAnswers;
  final Function(String?) onResponseSelected;

  @override
  State<MultipleCorrectionWidget> createState() =>
      _MultipleCorrectionWidgetState();
}

class _MultipleCorrectionWidgetState extends State<MultipleCorrectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponseContainer(
          response: widget.answers[0]
              .replaceAll("&#039;", "'")
              .replaceAll("&quot;", '"')
              .replaceAll("&amp;", "&"),
          order: widget.wrongAnswers.contains(widget.answers[0]) ? "X" : "O",
          color: widget.wrongAnswers.contains(widget.answers[0])
              ? Colors.red
              : Colors.green,
        ),
        ResponseContainer(
          response: widget.answers[1]
              .replaceAll("&#039;", "'")
              .replaceAll("&quot;", '"')
              .replaceAll("&amp;", "&"),
          order: widget.wrongAnswers.contains(widget.answers[1]) ? "X" : "O",
          color: widget.wrongAnswers.contains(widget.answers[1])
              ? Colors.red
              : Colors.green,
        ),
        ResponseContainer(
          response: widget.answers[2]
              .replaceAll("&#039;", "'")
              .replaceAll("&quot;", '"')
              .replaceAll("&amp;", "&"),
          order: widget.wrongAnswers.contains(widget.answers[2]) ? "X" : "O",
          color: widget.wrongAnswers.contains(widget.answers[2])
              ? Colors.red
              : Colors.green,
        ),
        ResponseContainer(
          response: widget.answers[3]
              .replaceAll("&#039;", "'")
              .replaceAll("&quot;", '"')
              .replaceAll("&amp;", "&"),
          order: widget.wrongAnswers.contains(widget.answers[3]) ? "X" : "O",
          color: widget.wrongAnswers.contains(widget.answers[3])
              ? Colors.red
              : Colors.green,
        ),
      ],
    );
  }
}
