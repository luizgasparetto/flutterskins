import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  late String cid;
  late String category;
  late String productId;

  late int quantity;

  //late ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    cid = snapshot.id;
    category = snapshot['category'];
    productId = snapshot['pid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'productId': productId,
      'quantity': quantity,
      //'product': productData.toResumedMap(),
    };
  }
}
