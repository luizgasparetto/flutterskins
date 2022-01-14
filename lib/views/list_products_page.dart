import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/tiles/product_tile.dart';

class ProductsPage extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const ProductsPage({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(snapshot['title']),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color.fromRGBO(130, 87, 229, 1),
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('categories')
              .doc(snapshot.id)
              .collection('items')
              .get(),
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
              child: TabBarView(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                  ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        type: "list",
                        product: ProductData.fromDocument(
                          snapshot.data!.docs[index],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
