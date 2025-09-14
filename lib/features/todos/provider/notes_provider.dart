import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/database_services/supabase_client_mngr.dart';
import '../data/models/todo_model.dart';

class NotesProvider with ChangeNotifier{

  List<NotesModel> _notes = [];

  List<NotesModel> get notes => _notes;


  Future<void> fetchNotes() async {
    final userId = SupabaseClientManager.client.auth.currentUser?.id;
    final response = await SupabaseClientManager.client
        .from('notes')
        .select()
        .eq('user_id', userId as String)
        .order('created_at', ascending: false);
    _notes = (response as List).map((e) => NotesModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addNotes(String title,String description,List<String> tags) async{
    await SupabaseClientManager.client.from('notes').insert(
      {
        'title': title,
        'description': description,
        'tags': tags,
        'user_id': SupabaseClientManager.client.auth.currentUser?.id,
      },
    );
  await fetchNotes();

  }


Future<void> updateNotes(NotesModel notesModel)async{
    await SupabaseClientManager.client.from('notes').
    update(notesModel.toMap()).
    eq('user_id', notesModel.id);
    await fetchNotes();

}

Future<void> deleteNotes(NotesModel notesModel)async{
    await SupabaseClientManager.client.from('notes').
    delete().
    eq('id', notesModel.id);
    await fetchNotes();

}

}

