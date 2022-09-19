import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/note_screen.dart';
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

Widget appBar(context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(75.0),
      ),
    ),
    height: MediaQuery.of(context).size.height / 5,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'All Notes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        )
      ],
    ),
  );
}

Widget emptyList(BuildContext context) {
  return ListView(
    children: [
      appBar(context),
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
