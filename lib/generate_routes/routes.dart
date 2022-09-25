import 'package:flutter/material.dart';
import 'package:notes_app/screens/main_screen.dart';
import 'package:notes_app/screens/note_screen.dart';

generateRoutes(RouteSettings settings) {
  if (settings.name == NoteScreen.route) {
    final args = int.parse(settings.arguments.toString());
    //final value = settings.arguments as int; // Retrieve the value.
    return MaterialPageRoute(
        builder: (_) => NoteScreen(
              id: args,
            )); // Pass it to BarPage.
  }
  if (settings.name == MainScreen.route) {
    return MaterialPageRoute(builder: (_) => const MainScreen());
  }
  return null; // Let `onUnknownRoute` handle this behavior.
}
