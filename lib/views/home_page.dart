//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/widgets/tiles/product_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('bestsellers').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(130, 87, 229, 1),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ProductTile(
                type: "grid",
                product: ProductData.fromDocument(
                  snapshot.data!.docs[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
