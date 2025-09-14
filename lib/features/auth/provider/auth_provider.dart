import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/database_services/supabase_client_mngr.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkUserLoggedIn() async {
    final user = await SupabaseClientManager.client.auth.currentUser;
    _isLoggedIn = user != null;
  }

  Future<bool> login(String email, String password) async {
    try {
      final res = await SupabaseClientManager.client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (res.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password, String phone,) async {
    try {
      final res = await SupabaseClientManager.client.auth.signUp(
        password: password,
        email: email,
        data: {'name': name, 'phone': phone},
      );

      if (res.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> logOut() async {
    await SupabaseClientManager.client.auth.signOut();
    notifyListeners();
  }
}
