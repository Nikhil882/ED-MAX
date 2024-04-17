import 'package:edmax/utils/colors.dart';
import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {super.key, required this.result, required this.questionLength});
  final int result;
  final int questionLength;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor1,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Result",
              style: TextStyle(
                color: neutral,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              child: Text('$result/$questionLength'),
            ),
          ],
        ),
      ),
    );
  }
}
