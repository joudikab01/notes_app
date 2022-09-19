import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
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
              body: Consumer<NoteProvider>(
                child: emptyList(context),
                builder: (context, noteProvider, child) =>
                    noteProvider.items.length <= 0
                        ? child!
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: noteProvider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return header();
                              } else {
                                final i = index - 1;
                                final item = noteProvider.items[i];
                                print(item.title);
                                return NotesItem(
                                  id: item.id,
                                  title: item.title,
                                  content: item.body,
                                  //date: item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Provider.of<NoteProvider>(context, listen: false)
                      .addOrUpdateNote(4, 'fourth', 'ths is my content', true);
                  // goToNoteEditScreen(context);
                },
                child: Icon(Icons.add),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

Widget header() {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(75.0),
        ),
      ),
      height: 150.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notes',
          )
        ],
      ),
    ),
  );
}

Widget emptyList(BuildContext context) {
  return ListView(
    children: [
      header(),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Image.asset(
              'assets/empty.jpg',
              fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
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
                          // goToNoteEditScreen(context);
                        }),
                  const TextSpan(text: '" to add new note')
                ]),
          ),
        ],
      ),
    ],
  );
}

class NotesItem extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  //final String date;
  const NotesItem(
      {required this.id,
      required this.title,
      required this.content,
      // required this.date,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height/12,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(title),
          ],
        ),
      ),
    );
  }
}
