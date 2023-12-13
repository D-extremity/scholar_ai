import 'package:flutter/material.dart';
import 'package:scholar_ai/utils/colours.dart';

List<Map<String, String>> chatDetails = [
  {'user': 'bot', 'message': 'Hello , You can ask your query here . '},
];

Widget getChat(String user, String message) {
  return user == "bot"
      ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue.shade900,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom:8.0,top: 8.0),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
}

class Chat extends StatelessWidget {
  final constraints;
  final content;
  const Chat({super.key, required this.constraints, required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: content['user'].toString() == "bot"
            ? Alignment.bottomLeft
            : Alignment.bottomRight,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            getChat("${content['user']}", "  ${content['message']}  "),
            SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}
