import 'package:flutter/widgets.dart';
import 'package:todo_app/core/database_services/supabase_client_mngr.dart';
import 'package:todo_app/features/products/data/models/items_model.dart';

class ItemProvider with ChangeNotifier {
  List<ItemsModel> _list = [];
  List<ItemsModel> get listItem => _list;
  // Immediate invoked
  ItemProvider() {
    fetchItem();
  }
  // Current User Id
  final userId = SupabaseClientManager.client.auth.currentUser?.id;

  // Fetch the Items
  Future<void> fetchItem() async {
    final res = await SupabaseClientManager.client
        .from('items')
        .select()
        .eq('user_id', userId as String)
        .order('created_at', ascending: false);
    _list = (res as List).map((e) => ItemsModel.fromMap(e)).toList();
    notifyListeners();
  }

  // Create Items
  Future<void> addItem(
    String title,
    String description,
    String image,
    int price,
    int review,
    String bradName,
    String category,
  ) async {
    final userID = SupabaseClientManager.client.auth.currentUser?.id;
    await SupabaseClientManager.client.from('items').insert({
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'review': review,
      'brand_name': bradName,
      'category': category,        // ← Make sure you include this if present
      'created_at': DateTime.now().toIso8601String(),
      'user_id': userID,


    });
    await fetchItem();
  }

  // update the itmes
  Future<void> updateItem(
    String title,
    String description,
    int price,
    String review,
    String bradName,
    DateTime update,
  ) async {
    await SupabaseClientManager.client
        .from('items')
        .update({
          'title': title,
          'description': description,
          'price': price,
          'review': review,
          'brand_name': bradName,
          'updated_at': DateTime.now(),
        })
        .eq('user_id', userId as String);
    await fetchItem();
  }

  //   delete items
  Future<void> deleteItem(String id) async {
    SupabaseClientManager.client.from('items').delete().eq('id', id);
    await fetchItem();
  }
}
