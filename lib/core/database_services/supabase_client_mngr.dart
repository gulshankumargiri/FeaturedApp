import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/core/database_services/db_network.dart';

class SupabaseClientManager{
  static Future<void> init()async {
    await Supabase.initialize(url: apiUrl, anonKey: anonKey);
  }
  static SupabaseClient get client => Supabase.instance.client;
}

