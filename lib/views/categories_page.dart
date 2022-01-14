import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/widgets/categorie_tile.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 130),
      child: Column(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('categories').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var dividedTiles = ListTile.divideTiles(
                context: context,
                tiles: snapshot.data!.docs
                    .map((doc) => CategorieTile(docSnapshot: doc))
                    .toList(),
                color: Colors.transparent,
              ).toList();

              return Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: dividedTiles,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
