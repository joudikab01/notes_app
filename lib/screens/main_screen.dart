import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:provider/provider.dart';

import '../components/app_bar.dart';
import '../components/empty_list.dart';
import '../components/note_item.dart';

class MainScreen extends StatefulWidget {
  static const route = '/';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.white,
              extendBodyBehindAppBar: true,
              body: Consumer<NoteProvider>(
                child: emptyList(context),
                builder: (context, noteProvider, child) =>
                    noteProvider.items.isEmpty
                        ? child!
                        : Column(
                            children: [
                              appBar(context),
                              Expanded(
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: noteProvider.items.length,
                                  itemBuilder: (context, index) {
                                    final i = index;
                                    final item = noteProvider.items[i];
                                    return NotesItem(
                                      id: item.id,
                                      title: item.title,
                                      content: item.body,
                                      date: item.date,
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(NoteScreen.route, arguments: 0);
                },
                child: const Icon(Icons.add),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
