class ItemsModel {
  final String id;
  final String title;
  final String desc;
  final int price;
  final String image;
  final String review;
  final String bradName;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemsModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.review,
    required this.bradName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemsModel.fromMap(Map<String,dynamic>map){
    return ItemsModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      desc: map['description']?.toString() ?? '',
      price: map['price']??  0,
      image: map['image']?.toString() ?? '',
      review: map['review']?.toString() ?? '',
      bradName: map['bradName']?.toString() ?? '',
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );}

    Map<String,dynamic> toMap(){
    return{
        'id': id,
        'title': title,
        'description': desc,
        'price': price,
        'image': image,
        'review': review,
        'bradName': bradName,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String()
    };


  }
}
