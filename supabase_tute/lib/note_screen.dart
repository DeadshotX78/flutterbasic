import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController textController = TextEditingController();

  final notesStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  Future<void> fetchNotes() async {}

  Future<void> createNote() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Add a Note"),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          children: [
            TextFormField(
              controller: textController,
              onFieldSubmitted: (value) async {
                await Supabase.instance.client
                    .from('notes')
                    .insert({'content': value});
                textController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue,
        centerTitle: true,
        title: Text("QuickNotes with Supabase"),
      ),
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: notesStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final notes = snapshot.data!;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]['content']),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: createNote,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
