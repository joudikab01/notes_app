import 'package:flutter/material.dart';
import 'package:notes_app/screens/note_screen.dart';

generateRoutes(RouteSettings settings) {
  if (settings.name == NoteScreen.route) {
    //final value = settings.arguments as int; // Retrieve the value.
    return MaterialPageRoute(
        builder: (_) => const NoteScreen()); // Pass it to BarPage.
  }
  return null; // Let `onUnknownRoute` handle this behavior.
}
