import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              ref.add({
                "title": title.text,
                "content": content.text
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text("Save"),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: " Title"),
              controller: title,
            ),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.red,
            )),
          ),
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: content,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(hintText: " Content"),
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
