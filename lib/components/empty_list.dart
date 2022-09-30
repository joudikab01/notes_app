import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../screens/note_screen.dart';
import 'app_bar.dart';

Widget emptyList(BuildContext context) {
  return Column(
    children: [
      appBar(context),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Image.asset(
              'assets/empty.png',
              fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
            ),
          ),
          RichText(
            text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: ' There are no notes available\n Tap on "',
                  ),
                  TextSpan(
                      text: '+',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushNamed(NoteScreen.route, arguments: 0);
                        }),
                  const TextSpan(text: '" to add new note')
                ]),
          ),
        ],
      ),
    ],
  );
}
