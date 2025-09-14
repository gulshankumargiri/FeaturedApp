import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todos/data/models/todo_model.dart';
import 'package:todo_app/features/todos/provider/notes_provider.dart';
import 'package:todo_app/features/products/screens/all_items.dart';
import 'package:todo_app/features/todos/screens/pages/addNotes.dart';
import 'package:todo_app/features/products/screens/widgets/addProdItems.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({super.key});

  @override
  State<AllNotes> createState() => _AllNotesState();


}

class _AllNotesState extends State<AllNotes> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context,listen: false).fetchNotes();
  }
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes()));
          }, child: Text('Add Notes')),
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllItems()));
          }, child: Text('Items Page')),
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddItem()));
          }, child: Text('Add Items')),
        ],
      ),

      appBar: AppBar(title: Text('Logged In'),

        actions:[
          IconButton(onPressed: ()async{
            await notesProvider.fetchNotes();

          }, icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
      ),
      body: notesProvider.notes.isEmpty
          ? Center(child: Text('No Notes Found'))
          : ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {
          final note = notesProvider.notes[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[300],
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(note.title),
                  Text(note.description),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(note.createdAt.toString()),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await notesProvider.deleteNotes(note.id as NotesModel);
                        },
                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),

                    child: Text(
                      note.tags
                          .map((e) => e.toUpperCase())
                          .toString(),
                      style: TextStyle(
                        color: Colors.red,
                        backgroundColor: Colors.green[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
