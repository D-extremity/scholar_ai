import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scholar_ai/backend/palmapi.dart';
import 'package:scholar_ai/models/chatmodel.dart';
import 'package:scholar_ai/utils/colours.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  final TextEditingController _getUserchat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SCHOLAR AI",
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.9,
                  child: ListView.builder(
                    dragStartBehavior: DragStartBehavior.down,
                    reverse: false,
                    itemCount: chatDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Map<String, String>> finalChats = chatDetails;
                      finalChats.reversed;
                      Map<String, String> content = finalChats[index];
                      return Chat(
                        constraints: constraints,
                        content: content,
                      );
                    },
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.09,
                  child: Row(
                    children: [
                      SizedBox(
                          width: constraints.maxWidth * 0.8,
                          child: TextField(
                            controller: _getUserchat,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )),
                      SizedBox(
                          width: constraints.maxWidth * 0.15,
                          child: IconButton(
                              onPressed: () async {
                                String m = _getUserchat.text;
                                if (m.isEmpty) {
                                  return;
                                }
                                chatDetails
                                    .add({'user': 'human', 'message': m});
                                setState(() {
                                  _getUserchat.text = "";
                                });
                                String s = await makeApiRequest(m);
                                chatDetails.add({'user': 'bot', 'message': s});
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: constraints.maxWidth * 0.15,
                              ))),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
