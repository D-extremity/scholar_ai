import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_ai/firebasemethods/savenotes.dart';
import 'package:scholar_ai/pages/writenotes.dart';
import 'package:scholar_ai/utils/colours.dart';

class Notes extends StatelessWidget {
  final DocumentSnapshot document;
  final int index;
  const Notes({super.key, required this.index, required this.document});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                WriteNotesScreen(title: data['title'], note: data['content'])));
      },
      onLongPress: () async {
        if(data['uuid'].toString().endsWith("notes")){

        await StorageMethods().deleteuserNote(data['uuid'], context);
        }else{
        await StorageMethods().deleteNote(data['uuid'], context);

        }
      },
      child: index.isEven
          ? Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.shade900,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                    child: Center(
                      child: Text(
                        data["title"].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            )
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                    child: Center(
                      child: Text(
                        data['title'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
    );
  }
}
