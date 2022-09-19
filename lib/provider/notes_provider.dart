import 'package:flutter/material.dart';

import '../database.dart';
import '../models/models.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> _items = [];

  List<NoteModel> get items {
    return _items;
  }

  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    _items = notesList
        .map(
          (item) => NoteModel(item['id'], item['title'], item['content']),
        )
        .toList();

    notifyListeners();
  }

  NoteModel? getNote(int id) {
    return _items.firstWhere((note) => note.id == id,
        orElse: () => NoteModel(0, "", ""));
  }

  Future addNote(String title, String content) async {
    final db = DatabaseHelper.insert({
      'title': title,
      'content': content,
    });
    // final note = NoteModel(id, title, content);
    // _items.insert(0, note);
  }

  Future UpdateNote(int id, String title, String content) async {
    final note = NoteModel(id, title, content);

    _items[_items.indexWhere((note) => note.id == id)] = note;

    notifyListeners();

    DatabaseHelper.insert({
      'id': note.id,
      'title': note.title,
      'content': note.body,
    });
  }

  Future deleteNote(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }
}
