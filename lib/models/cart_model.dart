import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/data/cart_product.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';

class CartModel extends ChangeNotifier {
  AuthService auth;

  List<CartProduct> products = [];
  String? couponCode;
  int discountPercentage = 0;

  double subtotal = 0.0;

  CartModel({required this.auth});

  void addCarItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then(
          (doc) => {
            cartProduct.cid = doc.id,
          },
        );

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    products.remove(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCarItems() {
    final cartItems = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .get();

    return cartItems;
  }

  getItemOnCategorie(DocumentSnapshot product) {
    final item = FirebaseFirestore.instance
        .collection('categories')
        .doc(product['category'])
        .collection('items')
        .doc(product['productId'])
        .get();

    return item;
  }

  removeItem(DocumentSnapshot product, AuthService auth) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .doc(product.id)
        .delete();

    notifyListeners();
  }

  plusQuantity(DocumentSnapshot product, int quantidade) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .doc(product.id)
        .update({
      'quantity': quantidade + 1,
    });
  }

  minusQuantity(DocumentSnapshot product, int quantidade) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.usuario!.uid)
        .collection('cart')
        .doc(product.id)
        .update({
      'quantity': quantidade - 1,
    });

    notifyListeners();
  }

  void setCupom(String? couponCode, int discountPercent) {
    this.couponCode = couponCode;
    discountPercentage = discountPercent;
  }

  void updateSubtotal(double incrementPrice) {
    subtotal += incrementPrice;
    notifyListeners();
  }
}
