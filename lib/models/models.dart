import 'package:intl/intl.dart';

class NoteModel {
  int id;
  String title;
  String body;
  //DateTime dateTime;
  NoteModel(
    this.id,
    this.title,
    this.body,
    //this.dateTime,
  );

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('EEE h:mm a, dd/MM/yyyy').format(date);
  }
}
