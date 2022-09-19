import 'package:flutter/material.dart';
import 'package:notes_app/models/models.dart';
import 'package:provider/provider.dart';

import '../provider/notes_provider.dart';

class NoteScreen extends StatefulWidget {
  static const route = '/note_view';
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late NoteModel note;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late bool firstTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var id = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    if (Provider.of<NoteProvider>(context, listen: false).getNote(id) != null) {
      note = Provider.of<NoteProvider>(context, listen: false).getNote(id)!;
      _titleController.text = note.title;
      _contentController.text = note.body;
    }
    if (id == 0) {
      firstTime = true;
    } else {
      firstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'My Note',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (firstTime) {
                Provider.of<NoteProvider>(context, listen: false)
                    .addNote(_titleController.text, _contentController.text);
              } else {
                Provider.of<NoteProvider>(context, listen: false).UpdateNote(
                    note.id, _titleController.text, _contentController.text);
              }
              // Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<NoteProvider>(context, listen: false)
                  .deleteNote(note.id);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete_outline_sharp,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                decoration: const InputDecoration(
                    hintText: 'Enter Note Title', border: InputBorder.none),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                decoration: const InputDecoration(
                    hintText: 'Enter Note Title', border: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void saveNote() {
  //   String title = _titleController.text.trim();
  //   String content = _contentController.text.trim();
  //   int id = DateTime.now().millisecondsSinceEpoch;
  //   Provider.of<NoteProvider>(context, listen: false)
  //       .addOrUpdateNote(id, title, content, true);
  //
  //   ///TODO
  //   Navigator.of(context)
  //       .pushReplacementNamed('NoteViewScreen.route', arguments: id);
  // }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}
