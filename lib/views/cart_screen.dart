import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/database/auth/auth_service.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();
    final auth = context.read<AuthService>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: cart.getCarItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_shopping_cart,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add products to your cart!',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(4),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data!.docs[index];
                  dev.log(product.id);
                  //dev.log(quantidade.toString());
                  int quantity = product['quantity'];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color.fromRGBO(22, 27, 34, 0.6),
                    child: FutureBuilder<DocumentSnapshot>(
                      future: cart.getItemOnCategorie(product),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final item = ProductData.fromDocument(snapshot.data!);
                          final price = item.price * quantity;
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: Image.network(
                                    item.images[0],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${item.status} | ${item.float}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '\$ ${price.toStringAsFixed(2)}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: (quantity > 1)
                                              ? () {
                                                  cart.minusQuantity(
                                                      product, quantity);
                                                  setState(() {
                                                    quantity;
                                                  });
                                                }
                                              : null,
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            color: (quantity > 1)
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          '$quantity',
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (quantity < 9) {
                                              cart.plusQuantity(
                                                  product, quantity);
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.blueAccent,
                                            size: 16,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 40),
                                          child: IconButton(
                                            onPressed: () {
                                              cart.removeItem(product, auth);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.trash,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
