import 'package:flutter/material.dart';

import '../screens/note_screen.dart';
class NotesItem extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String date;
  const NotesItem(
      {required this.id,
        required this.title,
        required this.content,
        required this.date,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 10,
        right: 10,
      ),
      child: GestureDetector(
        onTap: () {
          ///TODO: onGenerate
          Navigator.pushNamed(context, NoteScreen.route, arguments: id);
        },
        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),
          height: MediaQuery.of(context).size.height / 12,
          decoration: BoxDecoration(
            color: Colors.pinkAccent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                content,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}