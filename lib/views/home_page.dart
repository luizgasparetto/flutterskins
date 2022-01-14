//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/data/ProductData.dart';
import 'package:lojavirtual/tiles/background_gradient.dart';
import 'package:lojavirtual/tiles/product_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBodyBack(
          color1: const Color.fromRGBO(23, 22, 31, 1),
          color2: const Color.fromRGBO(13, 17, 23, 1),
        ),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                  //title: buildTitle('Novidades'),
                  //centerTitle: true,
                  ),
            ),
            FutureBuilder<QuerySnapshot>(
              future:
                  FirebaseFirestore.instance.collection('bestsellers').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                }

                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 20, top: 0),
                        child: Text(
                          'Welcome',
                          style: GoogleFonts.montserrat(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 21,
                        margin: const EdgeInsets.only(left: 20, top: 0),
                        child: Text(
                          'Find your perfect CSGO skin',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
