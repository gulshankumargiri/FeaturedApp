import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/auth/provider/auth_provider.dart';
import 'package:todo_app/features/todos/screens/pages/addNotes.dart';
import 'package:todo_app/features/products/screens/widgets/addProdItems.dart';

import '../provider/item_provider.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});

  @override
  State<AllItems> createState() => _AllItemsState();


}

class _AllItemsState extends State<AllItems> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context,listen: false).fetchItem();
  }
  @override
  Widget build(BuildContext context) {
    final auth= Provider.of<AuthProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes()));
          }, child: Text('Add Notes')),
          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddItem()));
          }, child: Text('Add Items')),
        ],
      ),

      appBar: AppBar(title: Text('Logged In'),

        actions:[
          IconButton(onPressed: ()async{
            await itemProvider.fetchItem();

          }, icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
      ),
      body: itemProvider.listItem.isEmpty
          ? Center(child: Text('No Product Found'))
          : ListView.builder(
        itemCount: itemProvider.listItem.length,
        itemBuilder: (context, index) {
          final note = itemProvider.listItem[index];
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
                  Text(note.desc),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
