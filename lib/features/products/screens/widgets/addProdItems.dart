
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/pick_image.dart';
import 'package:todo_app/features/products/provider/item_provider.dart';

class AddItem extends StatefulWidget {

  AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final title = TextEditingController();

  final desc = TextEditingController();

  final price = TextEditingController();

  final brand = TextEditingController();

  final review = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? image;

  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage != null){
      setState(() {
        image = pickedImage;
      });
    }
  }


  void uploadProduct() async{

    if(formKey.currentState!.validate() ){
      final name = title.text.trim();
      final description = desc.text.trim();
      final branding = brand.text.trim();
      final reviews = review.text.trim();
      final prices = price.text.trim();
       image ;
      final item = Provider.of<ItemProvider>(context, listen: false);

      await item.addItem(name, description,prices,reviews as int ,branding as String,image as String);


    };

  }



  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Item Page'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 20,
            children: [
              image != null
                  ? GestureDetector(
                onTap: selectImage,
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(image!, fit: BoxFit.cover),
                  ),
                ),
              )
                  : GestureDetector(
                onTap: () {
                  selectImage();
                },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 40),
                            SizedBox(height: 15),
                            Text(
                              "Select Your Image",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],),),
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
              TextFormField(
                controller: brand,
                decoration: InputDecoration(
                  hintText: 'Brand',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 10.0,
                  ),
                ),
              ),
              TextFormField(
                controller: review,
                decoration: InputDecoration(
                  hintText: 'Review',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 10.0,
                  ),
                ),
              ),
              TextFormField(
                controller: price,
                decoration: InputDecoration(
                  hintText: 'Price',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    gapPadding: 10.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // lllllll
                      uploadProduct();
                      Future.delayed(Duration(seconds: 1));
                      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                        content: Text('Item Added'),
                        actions: [
                          TextButton(onPressed: (){
                            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                          }, child: Text('Close'))
                        ],
                        backgroundColor: Colors.green,
                      ));

                      },
                    child: Text('Add Item'),

                  ),

                ],),

              // Column(
              //   children: [
              //     image! == null ? GestureDetector(
              //       onTap: selectImage,
              //         child: Container(
              //             height: 100,
              //             width: 100,
              //             child: Image.file(image!))) : GestureDetector(
              //         onTap: (){
              //           selectImage();
              //         },
              //
              //         child: Text(' Select Image')),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
