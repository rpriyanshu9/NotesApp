import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditNote({this.docToEdit});
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title;
  TextEditingController content;
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.docToEdit.data()['title']);
    content = TextEditingController(text: widget.docToEdit.data()['content']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                "title": title.text,
                "content": content.text
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text("Save"),
          ),
          FlatButton(
            onPressed: () {
              widget.docToEdit.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));
            },
            child: Text("Delete"),
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
