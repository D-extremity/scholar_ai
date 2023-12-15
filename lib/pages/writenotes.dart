import 'package:flutter/material.dart';
import 'package:scholar_ai/firebasemethods/savenotes.dart';
import 'package:scholar_ai/utils/colours.dart';

class WriteNotesScreen extends StatefulWidget {
  final String title;
  final String note;
  const WriteNotesScreen({super.key, required this.title, required this.note});

  @override
  State<WriteNotesScreen> createState() => _WriteNotesScreenState();
}

class _WriteNotesScreenState extends State<WriteNotesScreen> {
  @override
  void initState() {
    _getUserTitle.text = widget.title;
    _getUserNote.text = widget.note;
    super.initState();
  }

  final StorageMethods _storage = StorageMethods();
  final TextEditingController _getUserNote = TextEditingController();
  final TextEditingController _getUserTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (_getUserTitle.text.isNotEmpty) {
                  _storage.storeUserNotes(
                      _getUserNote.text, _getUserTitle.text, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Title IS EMPTY"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.green, fontSize: 20),
              ))
        ],
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
            padding: EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                TextField(
                  controller: _getUserTitle,
                  maxLines: 2,
                  maxLength: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Note",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: _getUserNote,
                        maxLines: 30,
                        maxLength: 50000,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
