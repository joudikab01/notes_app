import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import '../models/models.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List<NoteModel> get items {
    return [..._items];
  }

  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    _items = notesList
        .map(
          (item) => NoteModel(
          item['id'], item['title'], item['content']),
    )
        .toList();

    notifyListeners();
  }

  Future addOrUpdateNote(int id, String title, String content,
      bool isAdd) async {
    final note = NoteModel(id, title, content);

    if (isAdd) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }

    notifyListeners();

    DatabaseHelper.insert({
      'id': note.id,
      'title': note.title,
      'content': note.body,
    });
  }
}