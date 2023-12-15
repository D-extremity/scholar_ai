import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> storeNotes(
      String content, String title, BuildContext context) async {
    try {
      final String uuid = DateTime.now().toString();
      await _store
          .collection(_auth.currentUser!.uid)
          .doc("$uuid")
          .set({'content': content, 'title': title, 'uuid': uuid});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Saved to Bookmarks"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to save"),
        backgroundColor: Colors.red,
      ));
    }
  }


  Future<void> storeUserNotes(
      String content, String title, BuildContext context) async {
    try {
      final String uuid = DateTime.now().toString();
      await _store
          .collection(_auth.currentUser!.uid+"notes")
          .doc("$uuid"+"notes")
          .set({'content': content, 'title': title, 'uuid': "${uuid}notes"});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Saved to notes"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to save"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Stream<QuerySnapshot> getNotes() {
    return _store.collection(_auth.currentUser!.uid).snapshots();
  }

   Stream<QuerySnapshot> getUserNotes() {
    return _store.collection(_auth.currentUser!.uid+"notes").snapshots();
  }

  Future<void> deleteNote(String docId, BuildContext context) async {
    try {
      await _store.collection(_auth.currentUser!.uid).doc(docId).delete();
     
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Network Error"),
        backgroundColor: Colors.red,
      ));
    }
  }


  Future<void> deleteuserNote(String docId, BuildContext context) async {
    try {
      await _store.collection(_auth.currentUser!.uid+"notes").doc(docId).delete();
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Network Error"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
