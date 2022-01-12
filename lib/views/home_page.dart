//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/widgets/background_gradient.dart';
import 'package:lojavirtual/widgets/text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: buildTitle('Novidades'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('home')
                  .orderBy('pos')
                  .get(),
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

                return SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  staggeredTiles: snapshot.data!.docs.map((doc) {
                    return StaggeredTile.count(
                        doc['x'], double.tryParse(doc['y'].toString()));
                  }).toList(),
                  children: snapshot.data!.docs.map((doc) {
                    return FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: doc['image'],
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
