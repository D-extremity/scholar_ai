import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_ai/backend/palmapi.dart';
import 'package:scholar_ai/firebasemethods/firebaseauth.dart';
import 'package:scholar_ai/models/chatmodel.dart';
import 'package:scholar_ai/pages/gptscreen.dart';
import 'package:scholar_ai/utils/colours.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "SCHOLAR AI",
                    style: TextStyle(
                        color: backgroundColor,
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxHeight * 0.04),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () =>
                        FirebaseAuthMethod(FirebaseAuth.instance).signOut(),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: constraints.maxHeight * 0.02),
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: constraints.maxHeight * 0.015,
              ),
              SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight / 2.5,
                  child: Card(
                    shadowColor: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Bookmarks",
                                style: TextStyle(color: Colors.green.shade200),
                              ),
                              Icon(
                                Icons.book,
                                color: Colors.green.shade200,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 2.5,
                child: Card(
                  shadowColor: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Notes",
                              style: TextStyle(color: Colors.green.shade200),
                            ),
                            Icon(
                              Icons.note,
                              color: Colors.green.shade200,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            String a = await getImageTotext(image!.path);
                            String m = await makeApiRequest(a);
                            chatDetails.add({'user': 'bot', 'message': m});
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatGptScreen()));
                          },
                          icon: const Icon(Icons.camera),
                          iconSize: constraints.maxWidth * 0.11,
                        ),
                        IconButton(
                            onPressed: () async {
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              String a = await getImageTotext(image!.path);
                              String m = await makeApiRequest(a);
                            chatDetails.add({'user': 'bot', 'message': m});
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatGptScreen()));
                            },
                            icon: const Icon(Icons.image),
                            iconSize: constraints.maxWidth * 0.11),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => ChatGptScreen()));
                      },
                      child: Text(
                        " Click Here To Text ",
                        style:
                            TextStyle(fontSize: constraints.maxHeight * 0.02),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic),
                        iconSize: constraints.maxWidth * 0.11),
                  ],
                ),
              )
            ],
          ),
        );
      },
    )));
  }
}

Future getImageTotext(final imagePath) async {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText =
      await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
  String text = recognizedText.text.toString();
  return text;
}
