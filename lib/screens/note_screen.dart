import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notes_provider.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Note',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
            ),
            TextField(
              controller: _contentController,
            ),
          ],
        ),
      ),
    );
  }

  void saveNote() {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();
    int id = DateTime
        .now()
        .millisecondsSinceEpoch;
    Provider.of<NoteProvider>(context, listen: false)
        .addOrUpdateNote(id, title, content, true);
    ///TODO
    Navigator.of(context)
        .pushReplacementNamed('NoteViewScreen.route', arguments: id);
  }
  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
