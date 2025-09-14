
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todos/data/models/todo_model.dart';
import 'package:todo_app/features/todos/provider/notes_provider.dart';

class AddNotes extends StatelessWidget {
  final title = TextEditingController();
  final desc = TextEditingController();

  AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final note = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Notes Page'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),
            TextFormField(
              controller: desc,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),

Row(children: [
  ElevatedButton(
    onPressed: () async {
      final titl = title.text.trim();
      final descr = desc.text.trim();

      await note.addNotes(titl, descr, ['test']);
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: Text('Note Added'),
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, child: Text('Close'))
        ],
        backgroundColor: Colors.green,
      ));},
    child: Text('Add Notes'),
  ),
  ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text('Back'),
  ),
],)

          ],
        ),
      ),
    );
  }
}
