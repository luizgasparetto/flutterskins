import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojavirtual/data/ProductData.dart';

class ProductPage extends StatefulWidget {
  final ProductData product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final ProductData product = widget.product;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 22, 31, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          product.images.length > 1
              ? Container(
                  margin: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Carousel(
                      images: product.images
                          .map((image) => NetworkImage(image))
                          .toList(),
                      showIndicator: true,
                      dotSize: 4,
                      dotSpacing: 15,
                      dotColor: Colors.white,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: const Color.fromRGBO(130, 87, 229, 1),
                      overlayShadowColors: Colors.blue,
                      autoplay: false,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(product.images[0]),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  '${product.status} | ${product.float}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.9),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                Text(
                  '\$ ${product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
