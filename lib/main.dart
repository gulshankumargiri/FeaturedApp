import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/database_services/supabase_client_mngr.dart';
import 'package:todo_app/features/auth/provider/auth_provider.dart';
import 'package:todo_app/features/auth/screens/sign_up_screen.dart';
import 'package:todo_app/features/products/provider/item_provider.dart';
import 'package:todo_app/features/todos/provider/notes_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseClientManager.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthProvider()),
    ChangeNotifierProvider(create: (_)=>NotesProvider()),
    ChangeNotifierProvider(create: (_)=>ItemProvider()),

  ],child:const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SupabaseClientManager.init();
    Future.microtask(() {
      Provider.of<AuthProvider>(context, listen: false).checkUserLoggedIn();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      home: SignupScreen(),
    );
  }
}
