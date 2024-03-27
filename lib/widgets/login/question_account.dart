import 'package:flutter/material.dart';

class QuestionAccount extends StatelessWidget {
  const QuestionAccount({
    super.key,
    required this.question,
    required this.tapText,
    this.screenView,
  });
  final String question;
  final String tapText;
  final Widget? screenView;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$question ",
            style: const TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (screenView == null) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return screenView!;
                    },
                  ),
                );
              }
            },
            child: Text(
              "  $tapText",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
