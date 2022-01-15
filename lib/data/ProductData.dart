import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  late String category;
  late String id;
  late String title;
  late double price;
  late List images;
  late String status;
  late double float;
  late List tags;
  late String type;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot['title'];
    price = snapshot['price'] + 0.0;
    images = snapshot['images'];
    status = snapshot['status'];
    float = snapshot['float'] + 0.0;
    tags = snapshot['tags'];
    type = snapshot['type'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'title': title,
      'float': float,
      'status': status,
      'price': price,
    };
  }
}
